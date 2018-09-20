FROM debian:8.10-slim
MAINTAINER Candido Tominaga

RUN cat /etc/apt/sources.list | \
    sed '1s#.*#deb http://ftp.br.debian.org/debian jessie main contrib non-free#' > /etc/apt/sources.list.new \
    && cat /etc/apt/sources.list.new > /etc/apt/sources.list

RUN apt-get update && apt-get install -y apache2 php mysql-server isc-dhcp-server


VOLUME ["/etc/apache2", "/etc/mysql" "/var/www/html/", "/var/lib/mysql","/var/log"]

EXPOSE 80 443 53 3306