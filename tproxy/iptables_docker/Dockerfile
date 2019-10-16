FROM debian:10-slim

# Repository Brazil BR
RUN cat /etc/apt/sources.list | \
    sed '1s#.*#deb http://ftp.br.debian.org/debian stretch main contrib non-free#' > /etc/apt/sources.list.new \
    && cat /etc/apt/sources.list.new > /etc/apt/sources.list

RUN apt-get -q update && \
    DEBIAN_FRONTEND=noninteractive apt-get -qy install --no-install-recommends iptables python curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    curl -sL --insecure -o /bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.0.1/dumb-init_1.0.1_amd64 && \
    chmod +x /bin/dumb-init

ADD deploy.py /tmp/deploy.py

ENTRYPOINT ["/bin/dumb-init"]

# Use unbuffered IO so output displays in docker-compose
CMD ["python", "-u", "/tmp/deploy.py"]
