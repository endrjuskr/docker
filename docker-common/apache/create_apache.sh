#! /bin/sh

SERVER_ROOT=/etc
for i in `seq 1 $1`
do
  if [ ! -e $SERVER_ROOT/apache2-$i ] ; then
    cp -a /etc/apache2 $SERVER_ROOT/apache2-$i

    mkdir $SERVER_ROOT/apache2-$i/scripts
    mkdir $SERVER_ROOT/apache2-$i/bin
    for a in a2enmod a2dismod a2ensite a2dissite apache2ctl ; do
      ln -s /usr/sbin/$a $SERVER_ROOT/apache2-$i/bin/$a-$i
    done

    mkdir -p $SERVER_ROOT/apache2-$i/logrotate.d/
    cp -a /etc/logrotate.d/apache2 $SERVER_ROOT/apache2-$i/logrotate.d/apache2-$i
    mkdir -p $SERVER_ROOT/apache2-$i/log/apache2-$i
    chmod 750 $SERVER_ROOT/apache2-$i/log/apache2-$i

    mkdir -p $SERVER_ROOT/apache2-$i/run/
    mkdir -p $SERVER_ROOT/apache2-$i/lock/

    cp $SERVER_ROOT/apache2-$i/apache2.conf $SERVER_ROOT/apache2-$i/apache2.conf.bak
    rm $SERVER_ROOT/apache2-$i/apache2.conf
    cat $SERVER_ROOT/apache2-$i/apache2.conf.bak | sed -e 's/StartServers          2/StartServers          4/g' > $SERVER_ROOT/apache2-$i/apache2.conf.bak2
    cat $SERVER_ROOT/apache2-$i/apache2.conf.bak2 | sed -e "s/\/var\/www/\/var\/www\/app$i/g" > $SERVER_ROOT/apache2-$i/apache2.conf

    rm $SERVER_ROOT/apache2-$i/apache2.conf.bak2 $SERVER_ROOT/apache2-$i/apache2.conf.bak

    rm -rf $SERVER_ROOT/apache2-$i/mods_available
    rm -rf $SERVER_ROOT/apache2-$i/mods_enabled
    ln -s /etc/apache2/mods-available $SERVER_ROOT/apache2-$i/mods_available
    ln -s /etc/apache2/mods-enabled $SERVER_ROOT/apache2-$i/mods_enabled
    rm -f $SERVER_ROOT/apache2-$i/envvars
    port=$((i + 79))
    host="$2:$port"
    echo $host
    cat apache_envvars_template | sed -e s/__NO_INSTANCE__/"$i"/g | sed -e s/__PORT__/"$port"/g | sed -e s/__HOST_IP__/"$host"/g > $SERVER_ROOT/apache2-$i/envvars
    chmod +x $SERVER_ROOT/apache2-$i/envvars
    rm -f $SERVER_ROOT/apache2-$i/ports.conf
    cat apache_ports_template | sed -e s/__NO_INSTANCE__/"$i"/g | sed -e s/__PORT__/"$port"/g | sed -e s/__HOST_IP__/"$2"/g > $SERVER_ROOT/apache2-$i/ports.conf

    cat apache_conf_template | sed -e s/__NO_INSTANCE__/"$i"/g | sed -e s/__PORT__/"$port"/g | sed -e s/__HOST_IP__/"$host"/g >> $SERVER_ROOT/apache2-$i/apache2.conf
  fi
done;
