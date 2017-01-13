cd /code

# install requred libs
apt-get update
apt-get install -y software-properties-common
add-apt-repository -y ppa:mosquitto-dev/mosquitto-ppa
apt-get update
apt-get -y upgrade
apt-get install -y gcc wget mosquitto libmosquitto-dev unzip make libssl-dev libmysqlclient-dev

# mosquito && mosquitto-auth-plug
wget https://codeload.github.com/jpmens/mosquitto-auth-plug/zip/0.0.8
unzip 0.0.8
wget http://mosquitto.org/files/source/mosquitto-1.4.9.tar.gz
tar -xvzf mosquitto-1.4.9.tar.gz

# install openssl
wget http://www.openssl.org/source/openssl-1.0.1.tar.gz
tar -xvzf openssl-1.0.1.tar.gz
cd openssl-1.0.1
./config --prefix=/usr/
make
make install

# move config
mv /tmp/make-auth /code/mosquitto-auth-plug-0.0.8/config.mk
mv /tmp/bridge.conf /etc/mosquitto/conf.d/bridge.conf

# build plugin
cd /code/mosquitto-auth-plug-0.0.8
make clean
make

# install mysql
debconf-set-selections <<< 'mysql-server mysql-server/root_password password fr'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password fr'
apt-get -y install mysql-server

# create database
mysql -pfr -e "CREATE DATABASE mosquitto"

