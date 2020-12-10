@echo ************** PostgreSQL DUMPALL Start : %date% %time% **************
@echo off

set "PGHOME=c:\edb\as13"
set "PGDATABASE=postgres"
set "PGUSER=enterprisedb"
set "PGHOST=localhost"
set "PGPORT=5444"

set "BACKUPDIR=e:\msyoun\temp"
set "DUMP_FILE=postgres_all_dump_%date%.sql"
set "DUMP_CMD=%PGHOME%\bin\pg_dumpall.exe"
set "DUMP_OPT=--host=%PGHOST% --username=%PGUSER% --encoding=UTF8 --if-exists --clean --superuser=%PGUSER% --file=%BACKUPDIR%\%DUMP_FILE% --no-password"

cd /d %BACKUPDIR%

%DUMP_CMD% %DUMP_OPT%

@echo on
@echo ************* PostgreSQL DUMPALL End : %date% %time% ******************  