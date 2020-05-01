::be sure exist folder "db" to store database

@echo off
@SET db=mydb




@SET user=root
@SET password=121321
@SET host=192.122.111.111
@SET path=C:\wamp64\bin\mysql\mysql5.7.14\bin\
@SET backupcommand=%path%mysqldump -h %host% -u%user% -p%password% --result-file="db\%db%.sql" %db%

::BACKUP
%backupcommand%

::RESTORE TO LOCAL MYSQL SEVER
@SET drop=%path%mysqladmin --user=root --password= -f drop %db%
@SET create=%path%mysqladmin --user=root --password= create %db%
@SET restore=%path%mysql --user=root --password= -D%db% -e "source  db/%db%.sql;"
%drop%
%create%
%restore%

echo Done!
pause
exit