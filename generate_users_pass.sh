#!/bin/bash
# This script will create all domains, database users and password to be used with Ansible.
for domain in $(cat domains.txt);
	do
	user=$(echo $domain | awk '{print substr($0,0,8)}' | cut -d"." -f1)
	pass=$(pwgen 12 1)
	printf "  $user:\n    db_us : $user\n    db_na : $user\n    pass : $pass\n    server_hostname : $domain\n" >> all.yml
	done
