#!/bin/bash

sudo dnf update -y
sudo dnf install memcached libmemcached -y


sudo systemctl enable memcached
sudo systemctl start memcached


firewall-cmd --permanent --zone=public --add-port=11211/tcp

nano /etc/sysconfig/memcached

PORT="11211"
USER="memcached"
MAXCONN="4096"
CACHESIZE="64"
OPTIONS="-s '/var/run/memcached/memcached.sock' -a 0766"

  
# Chu y thu muc: /var/run/memcached/
# mkdir /var/run/memcached/
# chmod 777 /var/run/memcached/

## memcached-tool /var/run/memcached/memcached.sock
