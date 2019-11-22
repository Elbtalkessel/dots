alias mssql.run='docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=IsThisStrongEnough?!" -p 1433:1433 --name mssql -d mcr.microsoft.com/mssql/server:2019-GA-ubuntu-16.04 && copy IsThisStrongEnough'
alias mssql.into="docker exec -it mssql /opt/mssql-tools/bin/sqlcmd -U SA -P 'IsThisStrongEnough?!' -S localhost"
alias mssql.stop='docker stop mssql'
