#!/bin/bash

VOLUME_HOME="/var/lib/mysql"
CONF_FILE="/etc/mysql/conf.d/my.cnf"
LOG="/var/log/mysql/error.log"

# Set permission of config file
chmod 644 ${CONF_FILE}
chmod 644 /etc/mysql/conf.d/mysqld_charset.cnf

StartMySQL ()
{
    /usr/bin/mysqld_safe > /dev/null 2>&1 &

    # Time out in 1 minute
    LOOP_LIMIT=13
    for (( i=0 ; ; i++ )); do
        if [ ${i} -eq ${LOOP_LIMIT} ]; then
            echo "Time out. Error log is shown as below:"
            tail -n 100 ${LOG}
            exit 1
        fi
        echo "=> Waiting for confirmation of MySQL service startup, trying ${i}/${LOOP_LIMIT} ..."
        sleep 5
        mysql -uroot -e "status" > /dev/null 2>&1 && break
    done
}

CreateMySQLUser()
{
	StartMySQL

    echo "Creating MySQL database ${ON_CREATE_DB}"
    mysql -uroot -e "CREATE DATABASE IF NOT EXISTS ${ON_CREATE_DB};"
    echo "Database created!"
    	
	PASS=${MYSQL_PASS}
	_word=$( [ ${MYSQL_PASS} ] && echo "preset" || echo "random" )
	echo "=> Creating MySQL user ${MYSQL_USER} with ${_word} password"

	mysql -uroot -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '$PASS'"
	mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'%' WITH GRANT OPTION"

	echo "=> Done!"

	mysqladmin -uroot shutdown
}

# Initialize empty data volume and create MySQL user
if [[ ! -d $VOLUME_HOME/mysql ]]; then
    echo "=> An empty or uninitialized MySQL volume is detected in $VOLUME_HOME"
    echo "=> Installing MySQL ..."
    if [ ! -f /usr/share/mysql/my-default.cnf ] ; then
        cp /etc/mysql/my.cnf /usr/share/mysql/my-default.cnf
    fi
    mysql_install_db > /dev/null 2>&1
    echo "=> Done!"
    echo "=> Creating admin user ..."
    CreateMySQLUser

StartMySQL
sysbench --test=oltp --oltp-table-size=1000000 --mysql-db=test --mysql-user=root  prepare
mysqladmin -uroot shutdown

tail -F $LOG & exec mysqld_safe
