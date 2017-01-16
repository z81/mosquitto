cd /code

# install requred libs
apt-get update
apt-get install -y software-properties-common
add-apt-repository -y ppa:mosquitto-dev/mosquitto-ppa
apt-get update
apt-get -y upgrade
apt-get install -y gcc wget mosquitto libmosquitto-dev unzip make libssl-dev libmysqlclient-dev

# mosquito && mosquitto-auth-plug
wget https://github.com/z81/mosquitto-auth-plug/archive/master.zip
unzip master.zip
wget http://mosquitto.org/files/source/mosquitto-1.4.9.tar.gz
tar -xvzf mosquitto-1.4.9.tar.gz

# install openssl
#wget http://www.openssl.org/source/openssl-1.0.1.tar.gz
#tar -xvzf openssl-1.0.1.tar.gz
#cd openssl-1.0.1
#./config --prefix=/usr/
#make
#make install

# move config
mv /tmp/make-auth /code/mosquitto-auth-plug-master/config.mk
mv /tmp/bridge.conf /etc/mosquitto/conf.d/bridge.conf

# build plugin
cd /code/mosquitto-auth-plug-master
make clean
make

# install mysql
DEBIAN_FRONTEND=noninteractive && apt-get install -y mysql-server mysql-client
service mysql start

# create database
mysql -p$MYSQL_ROOT_PASSWORD < /mosquitto.sql

# create test user