# https://github.com/arvindr226/alpine-lamp/blob/master/Dockerfile
# https://github.com/pluie-org/docker-images/tree/master/pluie/alpine-apache-php7
FROM pluie/alpine-apache-php7
MAINTAINER Candido Tominaga

RUN curl -sS https://getcomposer.org/installer | php7 -- --install-dir=/usr/bin --filename=composer 

RUN  rm -rf /var/cache/apk/*

# AllowOverride ALL
RUN sed -i '264s#AllowOverride None#AllowOverride All#' /etc/apache2/httpd.conf
#Rewrite Moduble Enable
RUN sed -i 's#\#LoadModule rewrite_module modules/mod_rewrite.so#LoadModule rewrite_module modules/mod_rewrite.so#' /etc/apache2/httpd.conf
# Document Root to /var/www/html/
RUN sed -i 's#/var/www/localhost/htdocs#/var/www/html#g' /etc/apache2/httpd.conf
#Start apache
RUN mkdir -p /run/apache2

RUN mkdir /var/www/html/

VOLUME  /var/www/html/
WORKDIR  /var/www/html/

EXPOSE 80
EXPOSE 443

CMD /usr/sbin/apachectl  -D   FOREGROUND