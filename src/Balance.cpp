#include "Precompiled.h"
#include "Balance.h"
#include "Application.h"
#include "Profile.h"

template<> Balance *Singleton<Balance>::mSingleton = NULL;

const std::string Balance::PARAMS[MAX_PARAMS] =
{
	"version", "state", "substate", "testmode", "spiinput", "drvcurr", "drvvolt", "wheelangle", "wheelspeed", "rofs",
	"rdiam", "rwidth", "weight0", "angle0", "rndweight0", "wheelangle0", "weight1", "angle1", "rndweight1", "wheelangle1",
	"weight2", "angle2", "rndweight2", "wheelangle2", "user", "msg1", "width", "diam", "offset", "split",
	"numsp", "mode", "layout", "stick", "roundmode", "minweight", "startmode", "covermode", "pedalmode", "automode",
	"clockwise", "truemode", "autoalu", "maxrot", "diamepsilon", "drvfreq", "minfreq", "accthld", "angleepsilon", "rulerhorz",
	"rulervert", "rulerrad", "rulerofs", "rulerdiam", "calweight", "deccurr", "decfreq", "weightdist", "v0", "v1",
	"v2", "v3", "v4", "v5", "va0", "va1", "va2", "va3", "va4", "va5",
	"va6", "va7", "w0", "w1", "w2", "w3", "freqcoeff", "rstick", "c0", "c1",
	"c2", "c3", "c4", "c5", "r0", "r1", "errors0", "errors1", "errors2", "wheeldist",
	"autoaluflag", "keycal0", "cheatepsilon", "rulercal0", "rulercal1", "rulercal2", "rulercal3", "rulercalf", "cal0", "cal1",
	"cal2", "cal3", "testdrv", "loaddef", "loadref", "saveref", "passwd", "start", "stop", "enter",
	"osc", "rotate", "c-meter"
};

Balance::Balance(Profile &profile)
: mProtocolValid(true), mSocketNameChanged(false)
{
	for (int i = 0; i < MAX_PARAMS; ++i)
		mParams.insert(std::make_pair(PARAMS[i], "0"));

	mSocketName = CL_SocketName(profile.getString("server_addr", "192.168.0.1"), "23");
	profile.setInt("language", profile.getInt("language", 0));
	profile.setString("server_addr", mSocketName.get_address());
	profile.setString("local_addr", profile.getString("local_addr", "127.0.0.1"));
	profile.setString("netmask", profile.getString("netmask", "255.255.255.0"));
	profile.setString("gateway", profile.getString("gateway", "127.0.0.1"));
	profile.setString("dns", profile.getString("dns", "127.0.0.1"));
	profile.setBool("remote_control", profile.getBool("remote_control", true));
	profile.setInt("input_dev", profile.getInt("input_dev", 1));
	profile.setString("cal_command", profile.getString("cal_command", "eGalaxTouch"));

	mSlotUpdate = Application::getSingleton().getSigUpdate().connect(this, &Balance::onUpdate);

	mThread.start(this);
}

Balance::~Balance()
{
	if (isConnected())
	{
		mStopThread.set(1);
		mThread.join();
	}
	else
	{
		mThread.kill();
	}
}

bool Balance::isConnected() const
{
	return mConnected.get() != 0;
}

bool Balance::isProtocolValid() const
{
	return mProtocolValid;
}

void Balance::setServerAddr(const std::string &addr)
{
	mNewSocketName = CL_SocketName(addr, "23");
	mSocketNameChanged = true;
}

std::string Balance::getParam(const std::string &name) const
{
	ParamMap::const_iterator it = mParams.find(name);
	if (it == mParams.end())
		throw Exception("Invalid parameter name '" + name + "' specified");
	return it->second;
}

int Balance::getIntParam(const std::string &name) const
{
	return CL_StringHelp::text_to_int(getParam(name));
}

float Balance::getFloatParam(const std::string &name) const
{
	return CL_StringHelp::text_to_float(getParam(name));
}

void Balance::setParam(const std::string &name, const std::string &value)
{
	ParamMap::iterator it = mParams.find(name);
	if (it == mParams.end())
		throw Exception("Invalid parameter name '" + name + "' specified");
	it->second = value;

	if (isConnected())
	{
		CL_MutexSection mutexSection(&mRequestMutex);
		mRequests.push_back(name + (!value.empty() ? " " + value : "") + "\r\n");
	}
}

void Balance::setIntParam(const std::string &name, int value)
{
	setParam(name, CL_StringHelp::int_to_text(value));
}

void Balance::setFloatParam(const std::string &name, float value)
{
	setParam(name, CL_StringHelp::float_to_text(value, 2));
}

void Balance::onUpdate(int delta)
{
	// process the reply queue
	CL_MutexSection mutexSection(&mReplyMutex);

	for (std::vector<std::string>::const_iterator it = mReplies.begin(); it != mReplies.end(); ++it)
	{
		std::istringstream stream(*it);
		std::string command;
		stream >> command;

		if (command == "params")
		{
			ParamMap params;
			for (int i = 0; i < MAX_INPUT_PARAMS; ++i)
				stream >> params[PARAMS[i]];

			if (params["version"] == "115")
			{
				mProtocolValid = true;
				for (ParamMap::const_iterator it = params.begin(); it != params.end(); ++it)
					mParams[it->first] = it->second;
			}
			else
			{
				mProtocolValid = false;
			}
		}
	}

	mReplies.clear();
	mutexSection.unlock();
}

void Balance::run()
{
	CL_ConsoleWindow console("Balance", 80, 100);

	for (;;)
	{
		try
		{
			if (mStopThread.get() != 0)
				return;

			if (mSocketNameChanged)
			{
				mSocketName = mNewSocketName;
				mSocketNameChanged = false;
			}

			CL_Console::write_line("Connecting...");
			mConnected.set(0);
			mRequests.clear();
			CL_TCPConnection connection = CL_TCPConnection(mSocketName);
			mConnected.set(1);
			CL_Console::write_line("*** OK ***");

			unsigned startTime = CL_System::get_time();
			int numRetries = 0;
			std::string data;
			for (;;)
			{
				if (mStopThread.get() != 0)
					return;

				if (mSocketNameChanged)
					break;

				int elapsedTime = CL_System::get_time() - startTime;
				if (elapsedTime >= POLL_INTERVAL)
				{
					startTime += POLL_INTERVAL;

					if (++numRetries > MAX_RETRIES)
					{
						CL_Console::write_line("*** TIMEOUT ***");
						break;
					}

					// first send all pending requests in the queue
					CL_MutexSection mutexSection(&mRequestMutex);

					for (std::vector<std::string>::const_iterator it = mRequests.begin(); it != mRequests.end(); ++it)
					{
						CL_Console::write_line("> " + it->substr(0, it->length() - 2));
						connection.write(it->c_str(), it->length());
					}

					mRequests.clear();
					mutexSection.unlock();

					// finally send the polling request
					std::string request = "state\r\n";
					CL_Console::write_line("> " + request.substr(0, request.length() - 2));
					connection.write(request.c_str(), request.length());
				}
				else
				{
					if (connection.get_read_event().wait(POLL_INTERVAL - elapsedTime))
					{
						// append received data to the data buffer
						char buf[1024];
						int size = connection.read(buf, sizeof(buf), false);
						data.append(buf, size);

						// split received data to CR+LF-terminated strings
						for (std::string::size_type pos = data.find("\r\n"); pos != std::string::npos; pos = data.find("\r\n"))
						{
							std::string reply = data.substr(0, pos + 2);
							CL_Console::write_line(reply.substr(0, reply.length() - 2));
							data.erase(0, pos + 2);
							numRetries = 0;

							CL_MutexSection mutexSection(&mReplyMutex);
							mReplies.push_back(reply);
						}
					}
				}
			}
		}
		catch (const std::exception &exception)
		{
			CL_Console::write_line(cl_format("*** FAIL: %1 ***", exception.what()));
			CL_System::sleep(1000);
		}
		catch (...)
		{
			CL_Console::write_line("*** FAIL ***");
			throw;
		}
	}
}
