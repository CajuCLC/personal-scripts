#!/bin/bash
mysqlfolder="/var/lib/mysql/"
date=`date '+%d-%B-%Y-%H%p'`
filename="mysql-$date.tgz"
folder=/home/backup/mysql
echo "TAR MySQL Folder..."
backup_dest=/home/backup/tendagospel.com/mysql
tar cvzfP "/home/backup/mysql/$filename" $mysqlfolder
./rack files object upload --container mysql --file "/home/backup/mysql/$filename" --name "$filename"
