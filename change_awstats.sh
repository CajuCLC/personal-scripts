#!/bin/bash
for dominio in $(cat list.txt);
        do
        user=$(echo $dominio | awk '{print substr($0,0,4)}' | cut -d"." -f1)
        domain=$(echo $dominio)
        echo sed -i "s/AllowAccessFromWebToFollowingAuthenticatedUsers=\"\"/AllowAccessFromWebToFollowingAuthenticatedUsers=\"$user\"/g" /etc/awstats/awstats.$domain.conf
        done
