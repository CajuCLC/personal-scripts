#!/bin/bash
domain=DOMAIN
date=`date '+%d-%B-%Y-%H%p'`
filename="$domain-$date.tgz"
folder=/home/backup/DOMAIN.com/web
echo "Gzipping domain folder..."
backup_source=/var/www/html
backup_dest=/home/backup/DOMAIN.com/mysql
tar cvzfP $folder/$filename $backup_source
echo "Upload to Cloud Files..."
~/./rack files object upload --conainter CONTAINER --name $filename --file $folder/$filename
echo "Removing gzip file..."
rm -f $folder/$filename
