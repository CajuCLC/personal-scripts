#!/bin/bash
# Simple script to get the domains and generate new ones, change config and create folders.
# Created by Eric Cavalcanti - Rackspace
for i in $(cat domains.txt)
    do
    cp default.conf $i.conf
    sed -i "s/default.com.br/$i/g" $i.conf
    mkdir /var/www/vhosts/$i
    done
