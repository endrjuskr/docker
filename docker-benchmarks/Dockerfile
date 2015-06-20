FROM debian:jessie
MAINTAINER Andrzej Skrodzki

ENV TERM linux
RUN apt-get -y update

RUN apt-get -y install apache2-utils sysbench

ADD run.sh /run.sh
RUN chmod 755 /*.sh

ADD logs/ /logs/

ENV BENCH **null**
ENV CL 5 
ENV NR 1000
ENV HOST http://localhost:80/index.html
ENV MHOST localhost
ENV MPORT 3306
ENV MTIME 60
ENV CPRIME 20000

CMD ["/run.sh"]
