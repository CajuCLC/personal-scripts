#!/bin/bash
echo "Getting domains"
httpd -S | grep "namevhost" | grep "port 80" | awk {' print $4 '} | sort | uniq > domains.txt
echo "LogLevel non-SSL"
for i in $(cat dominios.txt); do sed -i "s/#        LogLevel warn/#LogLevel warn/" /etc/httpd/vhost.d/$i.conf; done
echo "LogFormat"
for i in $(cat dominios.txt); do sed -i "s/        LogLevel warn/        LogLevel warn\n        LogFormat \"%h %l %u %t \\\\"\"%r\\\\"\" %>s %b \\\\"\"%{Referer}i\\\\"\" \\\\"\"%{User-Agent}i\\\\"\"\"/" /etc/httpd/vhost.d/$i.conf; done
