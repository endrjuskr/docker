#!/bin/bash

cd apache
chmod +x create_apache.sh
sh create_apache.sh 4 localhost

. /etc/apache2-1/envvars
/usr/sbin/apache2ctl -d /etc/apache2-1/ -k start

curl http://localhost:86/app1/index.php

sleep infinity
