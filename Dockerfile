# DOCKER-VERSION 1.0.0

FROM    centos:centos6

MAINTAINER Didier Fanchon

# Install dependencies for HHVM
# yum update -y >/dev/null && 
RUN yum install -y http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm  && curl -L -o /etc/yum.repos.d/hop5.repo "http://www.hop5.in/yum/el6/hop5.repo"

#install nginx, php, mysql, hhvm
RUN ["yum", "-y", "install", "nginx", "php", "php-mysql", "php-devel", "php-gd", "php-pecl-memcache", "php-pspell", "php-snmp", "php-xmlrpc", "php-xml","hhvm"]

# Create folder for server and add index.php file to for nginx
RUN mkdir -p /var/www/html && chmod a+r /var/www/html && echo "<?php phpinfo(); ?>" > /var/www/html/index.php

#Setup hhvm - add config for hhvm
ADD config.hdf /etc/hhvm/config.hdf 

# Start hvvm
RUN service hhvm restart

# ADD Nginx config
ADD nginx.conf /etc/nginx/conf.d/default.conf

# Start Nginx

RUN service nginx restart

EXPOSE 22 80

