FROM ubuntu:trusty
MAINTAINER Andrzej Skrodzki

# Install MySQL packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
  apt-get -yq install mysql-server-5.6 pwgen sysbench && \
    rm -rf /var/lib/apt/lists/*

# Install Apache2 packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -yq install \
        curl \
        apache2 \
        libapache2-mod-php5 \
        php5-mysql \
        php5-gd \
        php5-curl \
        php-pear \
        php-apc && \
    rm -rf /var/lib/apt/lists/* && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Remove pre-installed database
RUN rm -rf /var/lib/mysql/*

# Remove syslog configuration
RUN rm /etc/mysql/conf.d/mysqld_safe_syslog.cnf

# Add MySQL configuration
ADD my.cnf /etc/mysql/conf.d/my.cnf
ADD mysqld_charset.cnf /etc/mysql/conf.d/mysqld_charset.cnf

ADD run.sh /run.sh
RUN chmod 755 /*.sh
ADD apache /apache

# Exposed ENV
ENV MYSQL_USER admin
ENV MYSQL_PASS test1234
ENV ON_CREATE_DB test

ENV APACHE_1 **False**
ENV APACHE_2 **False**
ENV APACHE_3 **False**
ENV APACHE_4 **False** 

ENV APACHE_COUNT 0
ENV MYSQL_COUNT 0
ENV CPU_COUNT 0

# Add VOLUMEs to allow backup of config and databases
VOLUME  ["/etc/mysql", "/var/lib/mysql"]

# RUN mkdir -p /app_simple && mkdir /var/www/app1 && mkdir /var/www/app1/html && ln -s /app /var/www/app1/html
# RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html
ADD app_simple/ /app_simple
ADD app_intensive/ /app_intensive
ADD dacapo/ /dacapo


EXPOSE 86
EXPOSE 87
EXPOSE 88
EXPOSE 89

EXPOSE 3307
EXPOSE 3308
EXPOSE 3309
EXPOSE 3310

CMD ["/run.sh"]
