FROM mcr.microsoft.com/windows/servercore:20H2-amd64 AS install

ADD https://sbp.enterprisedb.com/getfile.jsp?fileid=1257893 /PgInstall.zip

SHELL [ "powershell" ]

RUN \
    Expand-Archive -Path PgInstall.zip -DestinationPath . ; \
    Remove-Item -Path C:\PgInstall.zip 

#FROM mcr.microsoft.com/windows/nanoserver:20H2-amd64

#COPY --from=install pgsql pgsql

#COPY ./Start.bat /Start.bat

ENV PGPORT=5432\
    PGDATA=C:\\Data\
    SUPERUSER=postgres\
    SUPERUSERPWD=postgres

EXPOSE 5432

WORKDIR /Data

SHELL [ "CMD" ]

WORKDIR /

# CMD C:\Start.bat

ENTRYPOINT \ 
IF EXIST "%PGDATA%\postgresql.conf"(\
    C:\pgsql\bin\pg_ctl.exe --options="-p %PGPORT%" -e PostgreSQL -N PostgreSQL --pgdata="%PGDATA%" start\
)ELSE(\
    C:\pgsql\bin\initdb.exe --pgdata="%PGDATA%" --username=%SUPERUSER% --auth=trust && \
    C:\pgsql\bin\pg_ctl.exe --options="-p %PGPORT%" -e PostgreSQL -N PostgreSQL --pgdata="%PGDATA%" start && \
    echo ALTER USER %SUPERUSER% WITH PASSWORD '%SUPERUSERPWD%' ; CREATE EXTENSION adminpack ; | C:\pgsql\bin\psql.exe --username=%SUPERUSER% \
)