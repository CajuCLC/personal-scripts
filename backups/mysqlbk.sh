#!/bin/bash
mysql=DB_NAME
date=`date '+%d-%B-%Y-%H%p'`
filename="$mysql-$date.tgz"
folder=/home/backup/DOMAIN.com/mysql
echo "Starting MySQL BackUP"
service mysqld start
echo "Dumping DB"
mysqldump -h XXX.XXX.XXX.XXX -u root -pPASSWORD --single-transaction $mysql > $folder/$mysql-$date.sql
echo "Export complete..."
echo "Gzipping sql file..."
backup_source=$folder/$mysql-$date.sql
backup_dest=/home/backup/DOMAIN.com/mysql
tar cvzfP $folder/$filename $backup_source
echo "Removing sql file..."
rm -f $folder/$mysql-$date.sql
echo "Stopping MySQL"
service mysqld stop
