FROM tomcat:9-jdk8-openjdk-slim

RUN cp /usr/local/tomcat/conf/server.xml /usr/local/tomcat/conf/server.xml.orig

ADD settings.xml /usr/local/tomcat/conf/
ADD tomcat-users.xml /usr/local/tomcat/conf/