#!/bin/bash

yum -y update
yum -y install memcached
systemctl enable memcached
firewall-cmd --permanent --zone=public --add-port=11211/tcp
service memcached start
 
echo "PORT=\"11211\"
USER=\"memcached\"
MAXCONN=\"4096\"
CACHESIZE=\"512\"
OPTIONS=\"\"
#OPTIONS=\"-l 127.0.0.1 -U 0\"
#OR CHANGE TO YOUR IP
" > /etc/sysconfig/memcached

head  /etc/sysconfig/memcached

echo "vi /etc/sysconfig/memcached    ----------- to update"


service memcached restart

# PORT="11211"
# USER="memcached"
# MAXCONN="8024"
# CACHESIZE="4096"
# OPTIONS=""

# Neu su  dung socket /var/run/memcached/memcached.sock
# PORT="11211" 
# USER="memcached" 
# MAXCONN="6024" 
# CACHESIZE="3640"
# OPTIONS="-s '/var/run/memcached/memcached.sock' -a 0766"

# Chu y thu muc: /var/run/memcached/
# mkdir /var/run/memcached/
# chmod 777 /var/run/memcached/
