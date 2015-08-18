#!/bin/bash

chown www-data:www-data /app_simple1 -R
chown www-data:www-data /app_simple2 -R
chown www-data:www-data /app_simple3 -R
chown www-data:www-data /app_simple4 -R

chown www-data:www-data /app_intensive1 -R
chown www-data:www-data /app_intensive2 -R
chown www-data:www-data /app_intensive3 -R
chown www-data:www-data /app_intensive4 -R


if [ "$APACHE_1" = "simple" ]; then
  ln -s /app_simple1 /var/www/app1/html
elif [ "$APACHE_1" = "intensive" ]; then
  ln -s /app_intensive1 /var/www/app1/html
fi

if [ "$APACHE_2" = "simple" ]; then
  ln -s /app_simple2 /var/www/app2/html
elif [ "$APACHE_2" = "intensive" ]; then
  ln -s /app_intensive2 /var/www/app2/html
fi

if [ "$APACHE_3" = "simple" ]; then
  ln -s /app_simple3 /var/www/app3/html
elif [ "$APACHE_3" = "intensive" ]; then
  ln -s /app_intensive3 /var/www/app3/html
fi

if [ "$APACHE_4" = "simple" ]; then
  ln -s /app_simple4 /var/www/app4/html
elif [ "$APACHE_4" = "intensive" ]; then
  ln -s /app_intensive4 /var/www/app4/html
fi

cd apache
chmod +x create_apache.sh
sh create_apache.sh $APACHE_COUNT localhost
for i in `seq 1 $APACHE_COUNT`
do
  source /etc/apache2-$i/envvars
  /usr/sbin/apache2ctl -d /etc/apache2-$i/ -k start
done;

sleep infinity
