FROM bitnami/minideb
MAINTAINER Candido H Tominaga<candido1212@gmail.com>

RUN echo "deb http://debian.c3sl.ufpr.br/debian/ stretch main"; \
	echo "deb http://debian.c3sl.ufpr.br/debian/ stretch contrib non-free"; \
	echo "deb http://debian.c3sl.ufpr.br/debian/ stretch non-free" >  /etc/apt/sources.list

CMD ["/bin/bash"]