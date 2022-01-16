IF EXIST "%PGDATA%\postgresql.conf" (
    C:\pgsql\bin\pg_ctl.exe --options="-p %PGPORT%" -e PostgreSQL -N PostgreSQL --pgdata="%PGDATA%" start
) ELSE (
    C:\pgsql\bin\initdb.exe --pgdata="%PGDATA%" --username=%SUPERUSER% --auth=trust
    C:\pgsql\bin\pg_ctl.exe --options="-p %PGPORT%" -e PostgreSQL -N PostgreSQL --pgdata="%PGDATA%" start
    echo ALTER USER %SUPERUSER% WITH PASSWORD '%SUPERUSERPWD%' ; CREATE EXTENSION adminpack ; | C:\pgsql\bin\psql.exe --username=%SUPERUSER%
)

REM TODO: Change configs directly on postgresql.conf


REM C:\pgsql\bin\postgres.exe -D "%PGDATA%" -p %PGPORT%

REM C:\pgsql\bin\pg_ctl.exe start --pgdata="%PGDATA%"
