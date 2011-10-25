#ifndef DATABASE_H
#define DATABASE_H

#include "Singleton.h"

class Database : public Singleton<Database>
{
public:

	Database();

	void execCommand(const std::string &text);

private:

	CL_SqliteConnection mConnection;
};

#endif
