#!/bin/bash
mysql=DB_NAME
date=`date '+%d-%B-%Y-%H%p'`
filename="$mysql-$date.tgz"
folder=/home/backup/DOMAIN.com/mysql
echo "Removing file..."
rm -f $folder/$mysql*
