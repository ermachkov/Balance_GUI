#ifndef DATABASE_H
#define DATABASE_H

#include "Singleton.h"

class Database : public Singleton<Database>
{
public:

	Database(const std::string &fileName);

	void execQuery(const std::string &text);

	void closeQuery();

private:

	CL_SqliteConnection mConnection;
	CL_DBReader         mReader;
};

#endif
