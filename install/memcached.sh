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