#!/bin/bash

cd apache
chmod +x create_apache.sh
sh create_apache.sh 4 127.0.0.1

cat /etc/apache2-1/envvars
cat /etc/apache2-1/ports.conf
cat /etc/apache2-1/apache2.conf

. /etc/apache2-1/envvars
/usr/sbin/apache2ctl -d /etc/apache2-1/ -k start
