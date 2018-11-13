#!/bin/bash

yum install wget
wget https://repo.mysql.com/mysql80-community-release-el7-1.noarch.rpm
rpm -ivh mysql80-community-release-el7-1.noarch.rpm
yum install mysql-community-server

echo "[mysqld]
port=3306
bind-address = 0.0.0.0
" >> /etc/my.cnf

service mysqld start

chkconfig mysqld on

grep 'temporary password' /var/log/mysqld.log

mysql_secure_installation

