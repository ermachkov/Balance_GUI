#include "Precompiled.h"
#include "Database.h"

template<> Database *Singleton<Database>::mSingleton = NULL;

Database::Database(const std::string &fileName)
: mConnection(fileName)
{
}

void Database::execQuery(const std::string &text)
{
	CL_DBCommand command = mConnection.create_command(text);
	mReader = mConnection.execute_reader(command);
}

void Database::closeQuery()
{
	mReader.close();
}
