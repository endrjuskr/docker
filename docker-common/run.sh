#!/bin/bash

chown www-data:www-data /app -R

cd apache
chmod +x create_apache.sh
sh create_apache.sh 4 localhost

source /etc/apache2-1/envvars

tail -F /var/log/apache2-1/* &
/usr/sbin/apache2ctl -d /etc/apache2-1/ -k start

sleep infinity
