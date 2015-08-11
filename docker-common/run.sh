#!/bin/bash

cd apache
chmod +x create_apache.sh
./create_apache.sh 4 127.0.0.1

. /etc/apache2-1/envvars
/usr/sbin/apache2ctl -d /etc/apache2-1/ -k start
