tutum-docker-php
================

Base docker image to run PHP applications on Apache


Building the base image
-----------------------

To create the base image `endrjuskr/php`, execute the following command on the tutum-docker-php folder:

    docker build -t endrjuskr/php .


Running your Apache+PHP docker image
------------------------------------

Start your image binding the external ports 80 in all interfaces to your container:

    docker run -d -p 80:80 endrjuskr/php

Test your deployment:

    curl http://localhost/

