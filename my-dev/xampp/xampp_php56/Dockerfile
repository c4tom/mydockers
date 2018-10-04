# Baseado em https://hub.docker.com/r/tomsik68/xampp/~/dockerfile/
FROM debian:jessie
MAINTAINER Candido Tominaga

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update --fix-missing

# curl is needed to download the xampp installer, net-tools provides netstat command for xampp
RUN apt-get -y install --no-install-recommends net-tools curl supervisor openssh-server vim less
RUN cd /root


# SSH server
RUN apt-get install -y -q supervisor openssh-server
RUN mkdir -p /var/run/sshd
# Output supervisor config file to start openssh-server
RUN echo "[program:openssh-server]" >> /etc/supervisor/conf.d/supervisord-openssh-server.conf
RUN echo "command=/usr/sbin/sshd -D" >> /etc/supervisor/conf.d/supervisord-openssh-server.conf
RUN echo "numprocs=1" >> /etc/supervisor/conf.d/supervisord-openssh-server.conf
RUN echo "autostart=true" >> /etc/supervisor/conf.d/supervisord-openssh-server.conf
RUN echo "autorestart=true" >> /etc/supervisor/conf.d/supervisord-openssh-server.conf
# Allow root login via password
# root password is: root
RUN sed -ri 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
# Set root password
# password hash generated using this command: openssl passwd -1 -salt xampp root
RUN sed -ri 's/root\:\*/root\:\$1\$xampp\$5\/7SXMYAMmS68bAy94B5f\./g' /etc/shadow


# Create a /www folder and a symbolic link to it in /opt/lampp/htdocs. It'll be accessible via http://localhost:[port]/www/
# This is convenient because it doesn't interfere with xampp, phpmyadmin or other tools in /opt/lampp/htdocs
RUN mkdir -p /web/html
RUN chown www-data.www-data /web

RUN curl -v -k -o xampp-linux-installer.run 'http://downloadsapachefriends.global.ssl.fastly.net/xampp-files/5.6.37/xampp-linux-x64-5.6.37-0-installer.run?from_af=true'

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

RUN apt-get clean
VOLUME [ "/opt/lampp/logs", "/opt/lampp/var/mysql", "/web", "/opt/lampp/etc" ] 
EXPOSE 3306 80 22

# write a startup script
RUN echo '/opt/lampp/lampp start' >> /startup.sh
RUN echo '/usr/bin/supervisord -n' >> /startup.sh

ENV PATH $PATH:/opt/lampp/bin

CMD ["sh", "/startup.sh"]