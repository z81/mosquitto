FROM ubuntu:16.04
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:mosquitto-dev/mosquitto-ppa
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y sqlite3 libsqlite3-dev
RUN apt-get install -y gcc wget mosquitto libmosquitto-dev unzip make libssl-dev libmysqlclient-dev
RUN cd /code && wget https://github.com/jpmens/mosquitto-auth-plug/archive/master.zip
RUN cd /code && wget http://mosquitto.org/files/source/mosquitto-1.4.9.tar.gz
RUN cd /code && unzip master.zip
RUN cd /code && tar -zxvf mosquitto-1.4.9.tar.gz
COPY make-auth /code/mosquitto-auth-plug-master/config.mk
COPY bridge.conf /etc/mosquitto/conf.d
RUN make clean
RUN make
ENTRYPOINT bash
EXPOSE 1883
WORKDIR ./code
ADD ./code /code
CMD ["restart-mqtt", "service mosquitto restart"]