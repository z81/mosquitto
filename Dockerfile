FROM ubuntu:16.04
ENV DEBIAN_FRONTEND noninteractive
RUN locale-gen ru_RU.UTF-8 && dpkg-reconfigure locales 
EXPOSE 1883
WORKDIR ./code
ADD ./code /code
ADD ./install.sh install.sh
ADD make-auth /tmp/make-auth
ADD bridge.conf /tmp/bridge.conf
RUN ./install.sh
ENTRYPOINT ["/bin/bash"]
CMD ["mosquitto -c /etc/mosquitto/conf.d/bridge.conf"]