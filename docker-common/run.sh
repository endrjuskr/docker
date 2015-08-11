#!/bin/bash

chown www-data:www-data /app -R

cd apache
chmod +x create_apache.sh
sh create_apache.sh 4 localhost

echo "ENVVARS -> "
cat /etc/apache2-1/envvars

echo "PORTS -> "
cat /etc/apache2-1/ports.conf

echo "apache2.conf -> "
cat /etc/apache2-1/apache2.conf

ls -l /var/log/apache2-1/


source /etc/apache2-1/envvars

/usr/sbin/apache2ctl -d /etc/apache2-1/ -k start

tail -F /var/log/apache2-1/* &

sleep infinity
