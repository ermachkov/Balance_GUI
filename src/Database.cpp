#include "Precompiled.h"
#include "Database.h"

template<> Database *Singleton<Database>::mSingleton = NULL;

Database::Database()
: mConnection("balance.db")
{
}

void Database::execCommand(const std::string &text)
{
	CL_DBCommand command = mConnection.create_command(text);
	mConnection.execute_non_query(command);
}
