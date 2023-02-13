FROM mcr.microsoft.com/mssql/server:2022-latest

ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=abcDEF123#
ENV MSSQL_PID=Developer
ENV MSSQL_TCP_PORT=1433

COPY ./data/KanonGaming.bak /var/opt/mssql/backup/KanonGaming.bak

RUN ( /opt/mssql/bin/sqlservr & ) | grep -q "Service Broker manager has started" \
    && /opt/mssql-tools/bin/sqlcmd -S127.0.0.1 -Usa -PabcDEF123# -Q 'RESTORE DATABASE KanonGaming FROM DISK = "/var/opt/mssql/backup/KanonGaming.bak" WITH MOVE "KanonGaming" to "/var/opt/mssql/data/kanongaming.mdf", MOVE "KanonGaming_Log" to "/var/opt/mssql/data/kanongaming_log.ldf", NOUNLOAD, STATS = 5' \
    && pkill sqlservr

EXPOSE 1433