#!/bin/bash

BUILDD=`mktemp -d`

function setup_phpapache() {
  apt-get update
  apt-get install -y php5-common libapache2-mod-php5 php5-cli  
  apt-get install -y php5-mcrypt php5-curl php5-gd php5-mysql
  sudo php5enmod mcrypt
}

function setup_magento() {
  apt-get install -y wget
  wget -O "${BUILDD}/magento-1.7.0.2.tar.gz" "http://www.magentocommerce.com/downloads/assets/1.9.1.0/magento-1.9.1.0.tar.gz"
  tar -xzvf "${BUILDD}/magento-1.7.0.2.tar.gz" -C "${BUILDD}"
  mv ${BUILDD}/magento /var/www/html
  chmod -R o+w /var/www/html/magento/app/etc/
  chmod -R o+w /var/www/html/magento/var/
  chmod -R o+w /var/www/html/magento/media/
  /etc/init.d/apache2 restart
}

function setup_mysql() {
  apt-get install -y mysql-client mysql-server
  /etc/init.d/mysql start
  mysql -u root -e "create database magentodb";
}

setup_phpapache
setup_magento
setup_mysql
