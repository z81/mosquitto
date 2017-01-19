FROM ubuntu:16.04
MAINTAINER muzo0@yandex.ru
ENV DEBIAN_FRONTEND noninteractive
ENV MYSQL_ROOT_PASSWORD fr
RUN bash -c 'debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD"'
RUN bash -c 'debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD"'
RUN locale-gen ru_RU.UTF-8 && dpkg-reconfigure locales 
EXPOSE 1883
WORKDIR ./code
ADD ./code /code
ADD ./mosquitto.sql /mosquitto.sql
ADD make-auth /tmp/make-auth
ADD bridge.conf /tmp/bridge.conf
ADD ./install.sh install.sh
RUN ./install.sh
#ENTRYPOINT mosquitto -c /etc/mosquitto/conf.d/bridge.conf