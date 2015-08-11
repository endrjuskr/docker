#!/bin/bash

cd apache
chmod +x create_apache.sh
sh create_apache.sh 4 10.240.162.123

. /etc/apache2-1/envvars
/usr/sbin/apache2ctl -d /etc/apache2-1/ -k start

curl http://10.240.162.123:86/app1/index.php

sleep infinity
