#!/bin/bash

cd apache
chmod +x create_apache.sh
sh create_apache.sh 4 localhost

sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2-1/apache2.conf
a2enmod rewrite

. /etc/apache2-1/envvars
/usr/sbin/apache2ctl -d /etc/apache2-1/ -k start

curl http://localhost:86/app1/index.php

sleep infinity
