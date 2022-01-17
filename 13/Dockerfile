FROM mcr.microsoft.com/windows/servercore:20H2-amd64 AS install

ADD https://sbp.enterprisedb.com/getfile.jsp?fileid=1257893 /PgInstall.zip
ADD https://aka.ms/vs/17/release/vc_redist.x64.exe /vc_redist.x64.exe

SHELL [ "powershell" ]

RUN \
    & .\vc_redist.x64.exe /install /quiet /norestart ; \
    Expand-Archive -Path PgInstall.zip -DestinationPath . ; \
    Remove-Item -Path PgInstall.zip ; \
    Get-ChildItem -Recurse -Include cab1.cab -Path 'C:\ProgramData\Package Cache' | %{expand.exe -F:* $_ .\pgsql\lib}

FROM mcr.microsoft.com/windows/nanoserver:20H2-amd64

COPY --from=install /pgsql /pgsql

COPY ./Start.bat /Start.bat

ENV PGPORT=5432\
    PGDATA=C:\\Data\
    SUPERUSER=postgres\
    SUPERUSERPWD=postgres

EXPOSE 5432

WORKDIR /Data

SHELL [ "CMD" ]

WORKDIR /

CMD C:\Start.bat