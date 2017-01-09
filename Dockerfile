FROM ubuntu:16.04
EXPOSE 1883
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-add-repository ppa:mosquitto-dev/mosquitto-ppa
RUN apt-get update
RUN apt-get install -y python-software-properties
RUN apt-get install -y mosquitto
ENTRYPOINT mosquitto -c /etc/mosquitto/mosquitto.conf