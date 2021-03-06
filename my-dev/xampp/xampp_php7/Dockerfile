# Baseado em https://hub.docker.com/r/tomsik68/xampp/~/dockerfile/
FROM debian:jessie
MAINTAINER Candido Tominaga

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update --fix-missing

# curl is needed to download the xampp installer, net-tools provides netstat command for xampp
RUN apt-get -y install --no-install-recommends net-tools curl supervisor openssh-server vim less unzip
RUN cd /root

RUN curl -v -k -o xampp-linux-installer.run 'http://downloadsapachefriends.global.ssl.fastly.net/7.2.9/xampp-linux-x64-7.2.9-0-installer.run?from_af=true'

RUN chmod +x xampp-linux-installer.run
RUN bash -c './xampp-linux-installer.run'
RUN ln -sf /opt/lampp/lampp /usr/bin/lampp
RUN rm -f './xampp-linux-installer.run'

# Enable XAMPP web interface(remove security checks)
RUN sed -i.bak s'/Require local/Require all granted/g' /opt/lampp/etc/extra/httpd-xampp.conf

# Change /opt/lampp/htdocs to /web/html
RUN sed -i.bak s'#/opt/lampp/htdocs#/web/html#' /opt/lampp/etc/httpd.conf

# Enable includes of several configuration files
RUN mkdir /opt/lampp/apache2/conf.d && \
    echo "IncludeOptional /opt/lampp/apache2/conf.d/*.conf" >> /opt/lampp/etc/httpd.conf

# Create a /www folder and a symbolic link to it in /opt/lampp/htdocs. It'll be accessible via http://localhost:[port]/www/
# This is convenient because it doesn't interfere with xampp, phpmyadmin or other tools in /opt/lampp/htdocs
RUN mkdir -p /web/html /var/run/sshd 
RUN chown www-data.www-data /web

#RUN chmod mysql.mysql /opt/lampp/var/mysql

VOLUME [ "/opt/lampp/logs", "/opt/lampp/var/mysql", "/web" ] 

# Adicionando OCI driver
ADD oci.x64-18.3.0.0.0dbru.zip /tmp
COPY tools /tools
RUN chmod +x /tools/*
RUN cd /tmp ; unzip oci.x64-18.3.0.0.0dbru.zip; mv instantclient_18_3 /opt; \
     ln -sf instantclient_18_3 /opt/lampp/lib/instantclient-11.2.0.3.0


EXPOSE 3306 80 22


# write a startup script
RUN echo '/opt/lampp/lampp start' >> /startup.sh
RUN echo '/usr/bin/supervisord -n' >> /startup.sh

ENV PATH $PATH:/opt/lampp/bin

CMD ["bash", "/startup.sh"]