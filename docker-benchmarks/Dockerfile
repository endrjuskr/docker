FROM debian:jessie
MAINTAINER Andrzej Skrodzki

ENV TERM linux
RUN apt-get -y update

RUN apt-get -y install apache2-utils sysbench openjdk-7-jdk openjdk-7-jre

ADD run.sh /run.sh
RUN chmod 755 /*.sh

ADD logs/ /logs/
ADD dacapo.jar /dacapo.jar

ENV BENCH **null**
ENV CL 5 
ENV NR 1000
ENV COUNT 5
ENV HOST http://localhost:80/index.html
ENV MHOST localhost
ENV MPORT 3306
ENV MTIME 60
ENV CPRIME 20000
ENV DCMD **null**

CMD ["/run.sh"]
