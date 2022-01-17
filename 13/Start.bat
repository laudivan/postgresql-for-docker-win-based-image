IF EXIST "C:\data\postgresql.conf" (
    C:\pgsql\bin\pg_ctl.exe --options="-p %PGPORT%" -l logfile -e PostgreSQL -N PostgreSQL --pgdata="C:\data" start
) ELSE (
    C:\pgsql\bin\initdb.exe --encoding=%ENCODING% --locale=%LOCALE% --pgdata="C:\data" --username=%SUPERUSER% --auth=trust
    C:\pgsql\bin\pg_ctl.exe --options="-p %PGPORT%" -e PostgreSQL -N PostgreSQL --pgdata="C:\data" start
    echo ALTER USER %SUPERUSER% WITH PASSWORD '%SUPERUSERPWD%' ; CREATE EXTENSION adminpack ; | C:\pgsql\bin\psql.exe --username=%SUPERUSER%
)

REM TODO: Change configs directly on postgresql.conf


REM C:\pgsql\bin\postgres.exe -D "C:\data" -p %PGPORT%

REM C:\pgsql\bin\pg_ctl.exe start --pgdata="C:\data"
