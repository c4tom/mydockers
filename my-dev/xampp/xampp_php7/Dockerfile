FROM ubuntu:trusty
MAINTAINER Candido Tominaga

#ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update

# curl is needed to download the xampp installer, net-tools provides netstat command for xampp
RUN apt-get -y install net-tools curl 
RUN cd /root

RUN curl -o xampp-linux-installer.run 'https://downloadsapachefriends.global.ssl.fastly.net/xampp-files/5.6.37/xampp-linux-x64-5.6.37-0-installer.run?from_af=true'

RUN chmod +x xampp-linux-installer.run
RUN bash -c './xampp-linux-installer.run'
RUN ln -sf /opt/lampp/lampp /usr/bin/lampp

# Enable XAMPP web interface(remove security checks)
RUN sed -i.bak s'/Require local/Require all granted/g' /opt/lampp/etc/extra/httpd-xampp.conf


# Enable includes of several configuration files
RUN mkdir /opt/lampp/apache2/conf.d && \
    echo "IncludeOptional /opt/lampp/apache2/conf.d/*.conf" >> /opt/lampp/etc/httpd.conf

# Create a /www folder and a symbolic link to it in /opt/lampp/htdocs. It'll be accessible via http://localhost:[port]/www/
# This is convenient because it doesn't interfere with xampp, phpmyadmin or other tools in /opt/lampp/htdocs
RUN mkdir /www
RUN ln -s /www /opt/lampp/htdocs/


# Few handy utilities which are nice to have
RUN apt-get -y install nano vim less --no-install-recommends

RUN apt-get clean
VOLUME [ "/var/log/mysql/", "/var/log/apache2/" ]

EXPOSE 3306 80


# write a startup script
RUN echo '/opt/lampp/lampp start' >> /startup.sh
RUN echo '/usr/bin/supervisord -n' >> /startup.sh

CMD ["sh", "/startup.sh"]