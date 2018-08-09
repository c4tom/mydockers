FROM bitnami/minideb:stretch
MAINTAINER Candido H Tominaga <candido1212@gmail.com>

RUN echo "deb http://ftp.br.debian.org/debian stretch main\ndeb http://security.debian.org/ stretch/updates main" > /etc/apt/sources.list
RUN apt-get update
RUN install_packages curl ca-certificates net-tools iputils-ping 
RUN install_packages x11-apps mate-terminal

RUN apt-get clean

COPY .Xauthority $HOME/
# volume mappings
# VOLUME <folder list> ex.: /web /home

# Expose ports
# EXPOSE <ports> ex.: 22 80

ENV DISPLAY :0

CMD mate-terminal
