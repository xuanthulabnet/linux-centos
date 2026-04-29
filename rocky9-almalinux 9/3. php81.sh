#!/bin/bash
# BUILD PHP - FPM FROM SOURCE
sudo dnf config-manager --set-enabled crb
sudo dnf update -y


	 

sudo dnf install -y epel-release
sudo dnf install -y https://rpms.remirepo.net/enterprise/remi-release-9.rpm
sudo dnf module reset php -y
sudo dnf module enable php:remi-8.1 -y
sudo dnf install -y php php-cli php-fpm php-mysqlnd php-opcache php-gd php-curl php-zip php-mbstring php-xml php-intl

dnf install php-pecl-redis5 -y

sudo systemctl enable php-fpm
sudo systemctl start php-fpm



 /etc/php-fpm.d/www.conf
[www]
listen = /run/php-fpm/www.sock
;listen = 127.0.0.1:9000
listen.backlog = -1
listen.allowed_clients = 127.0.0.1
listen.owner = nginx
listen.group = nginx
listen.mode = 0660
user = nginx
group = nginx
pm = dynamic
pm.max_children = 3000
pm.start_servers = 32
pm.min_spare_servers = 16
pm.max_spare_servers = 32
pm.status_path = /status
pm.max_requests = 1000
ping.path = /ping
ping.response = pong
request_terminate_timeout = 100
request_slowlog_timeout = 10s
slowlog = /var/log/php-fpm/www-slow.log
 
  
 
 

sudo dnf install -y gcc gcc-c++ make autoconf pkgconfig zlib-devel libmemcached-devel
sudo dnf config-manager --set-enabled crb
sudo dnf install -y php81-php-devel php81-php-pear
dnf install php-pear php-devel gcc make

pecl install memcached
pecl install memcache
dnf install -y php-soap
dnf install php-bcmath
pecl install zip

 
    
# ************ ADD PHP.INI - /etc/php.ini (php --ini)

 
session.save_handler = memcached
;session.save_path = "youripd:11211"
session.save_path = "/var/run/memcached/memcached.sock"


memcached.sess_locking = 0
memcached.sess_prefix = 'memc.sess.'


zend_extension=opcache.so;
opcache.interned_strings_buffer=32
opcache.max_accelerated_files=32531
opcache.memory_consumption=240
opcache.revalidate_freq=300
opcache.fast_shutdown=0
opcache.enable_cli=0

expose_php=Off
date.timezone=Asia/Ho_Chi_Minh
short_open_tag = On



/etc/php-fpm.d/www.conf
    user = nginx
    group = nginx
    listen = /run/php-fpm/www.sock

