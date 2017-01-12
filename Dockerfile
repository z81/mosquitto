FROM ubuntu:16.04
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-add-repository ppa:mosquitto-dev/mosquitto-ppa
RUN apt-get update
RUN apt-get install -y python-software-properties
RUN apt-get install -y mosquitto
COPY bridge.conf /etc/mosquitto/conf.d
ENTRYPOINT mosquitto -c /etc/mosquitto/mosquitto.conf
EXPOSE 1883
WORKDIR ./code
ADD ./code /code
CMD ["restart-mqtt", "service mosquitto restart"]