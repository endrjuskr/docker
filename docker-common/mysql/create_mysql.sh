#!/bin/bash

service mysql stop

for i in `seq 1 $1`;
do
    port=$((3306+$i))
    cp mysql_config_template /etc/mysql/my$port.cnf
    sed -i "s/__PORT__/$port/g" /etc/mysql/my$port.cnf
    mkdir /var/log/mysql/mysql$port
    mkdir /var/lib/mysql$port
    mkdir /var/lib/mysql$port/mysql
    mkdir /var/lib/mysql$port/test
    chown -R mysql:mysql /var/lib/mysql$port
    chmod -R 755 /var/lib/mysql$port
    chown -R mysql:mysql /var/log/mysql/mysql$port
    chmod -R 755 /var/log/mysql/mysql$port
done;
