
FROM debian:9-slim
MAINTAINER Candido Tominaga

ENV DEBIAN_FRONTEND=noninteractive

RUN cat /etc/apt/sources.list | \
    sed '1s#.*#deb http://ftp.br.debian.org/debian stretch main contrib non-free#' > /etc/apt/sources.list.new \
    && cat /etc/apt/sources.list.new > /etc/apt/sources.list

RUN apt-get update && apt-get -qy install curl apt-utils

RUN cd /root

WORKDIR /root

RUN curl -O http://vestacp.com/pub/vst-install-debian.sh





CMD [ "bash" ]