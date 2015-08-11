#!/bin/bash

service mysql start

for i in `seq 1 $1`;
do
    port=$((3306+$i))
    mysql_install_db --verbose --datadir=/var/lib/mysql$port --defaults-file=/etc/mysql/my$port.cnf --user=mysql
done;