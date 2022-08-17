#!/bin/bash
# BUILD PHP - FPM FROM SOURCE
yum install autoconf libtool libmemcached-devel re2c bison sqlite-devel oniguruma-devel \
    libxml2-devel bzip2-devel libcurl-devel libpng-devel libzip-devel zlib \
	libicu-devel gcc-c++ libmcrypt-devel libwebp-devel libjpeg-devel openssl-devel -y
	



#https://github.com/php/php-src/releases

# example: xuanthulab
read -p "User run php-fpm (nginx): " user
user=${user:-nginx}

# example: xuanthulab
read -p "Group run php-fpm (nginx): " group
group=${group:-nginx}

read -p "PHP Version (php-8.0.22): " phpver
phpver=${phpver:-8.0.22}


read -p "PHP PATH (/usr/local/php): " prefix
prefix=${prefix:-/usr/local/php}
  
dircodephp="php-src-php-$phpver"
configpath="$prefix/etc"
 

rm -rf $dircodephp

curl -O -L https://github.com/php/php-src/archive/php-$phpver.tar.gz
tar -zxvf php-$phpver.tar.gz

extdir=$dircodephp/ext

cd "${extdir}"
#EXT MEMCACHED memcached 3.0.4
pecl channel-update pecl.php.net
pecl download memcached
tar -xvf memcached-3.2.0.tgz
mv memcached-3.2.0 memcached



cd ..
#cd "${dircodephp}"




./buildconf --force


./configure \
        --prefix=$prefix \
        --exec-prefix=$prefix \
        --enable-gd \
        --with-gettext \
        --with-libxml-dir=/usr/local/lib \
        --with-config-file-path=$configpath \
        --with-apxs2=/usr/bin/apxs \
        --with-kerberos \
        --with-openssl \
        --with-mhash \
        --with-pear \
        --with-zlib \
        --with-jpeg \
        --with-webp \
        --with-png-dir=/usr/lib64 \
        --with-jpeg-dir=/usr/lib64 \
        --enable-zip \
        --enable-exif \
        --enable-bcmath \
        --enable-calendar \
        --enable-memcached \
        --with-libmemcached-dir=/usr \
        --enable-sockets \
        --enable-soap \
        --enable-mbstring \
        --enable-intl \
        --enable-fpm \
        --enable-short-tags \
        --enable-opcache \
        --with-pcre-regex \
        --with-pcre-jit \
        --with-bz2 \
        --with-curl \
        --with-mysqli \
        --enable-pcntl \
        --with-pdo-mysql

	
make clean
make
make install

cp php.ini-development $configpath/php.ini

echo "#PHP PATH
export PHP_HOME=$prefix
export PATH=\$PHP_HOME/bin:\$PATH" >> /etc/profile

source /etc/profile

echo "CONFIG PHP-FPM"
cp ./sapi/fpm/init.d.php-fpm /usr/local/bin/php-fpm
chmod +x /usr/local/bin/php-fpm

cat <<EOF >$configpath/php-fpm.conf
;;;;;;;;;;;;;;;;;;
; Global Options ;
;;;;;;;;;;;;;;;;;;
[global]
; Pid file
; Note: the default prefix is /usr/local/php/var
pid = run/php-fpm.pid
; Error log file
; Note: the default prefix is /usr/local/php/var
error_log = log/php-fpm.log

;;;;;;;;;;;;;;;;;;;;
; Pool Definitions ;
;;;;;;;;;;;;;;;;;;;;
include=$configpath/php-fpm.d/*.conf
EOF

cat <<EOF >$configpath/php-fpm.d/www.conf
[www]
listen = /usr/local/php/var/run/php-fpm.sock
;listen = 127.0.0.1:9000
listen.backlog = -1
listen.allowed_clients = 127.0.0.1
listen.owner = $user
listen.group = $group
listen.mode = 0660
user = $user
group = $group
pm = dynamic
pm.max_children = 10
pm.start_servers = 2
pm.min_spare_servers = 1
pm.max_spare_servers = 6
pm.status_path = /status
ping.path = /ping
ping.response = pong
request_terminate_timeout = 100
request_slowlog_timeout = 10s
slowlog = $prefix/var/log/www.log.slow
EOF

touch /usr/local/php/var/run/www-php-fpm.sock
chmod 777 /usr/local/php/var/run/www-php-fpm.sock

# Mofify /etc/systemd/system/php-fpm.service
# ProtectSystem=false

cp ./sapi/fpm/php-fpm.service /etc/systemd/system/
chmod +x /etc/systemd/system/php-fpm.service
systemctl enable php-fpm.service
systemctl start php-fpm.service

# service httpd restart

	
# echo "
# SetHandler \"proxy:fcgi://127.0.0.1:9000\"
# " >> /etc/httpd/conf/httpd.conf



# ***********  install Redis PHP Extension
# yum install php-pear php-devel
# pecl install igbinary igbinary-devel redis
# php -m | grep redis

# ***********  install memcache PHP Extension
# yum install php-pear
# yum install php-pecl-memcache
# pecl install memcached
# pecl install memcache

# ***********  install ZIP PHP Extension
# yum install pcre-devel gcc zlib zlib-devel
# pecl install zip

# error : find /usr/local -iname 'zipconf.h'
# Delete the old version first

# yum remove -y libzip

# Download, compile and install
# wget https://nih.at/libzip/libzip-1.2.0.tar.gz
# tar -zxvf libzip-1.2.0.tar.gz
# cd libzip-1.2.0
# ./configure
# make && make install
#         cp /usr/local/lib/libzip/include/zipconf.h /usr/local/include/zipconf.h
 

# ************ ADD PHP.INI - /usr/local/php/etc/php.ini

# extension=redis.so
# extension=memcache.so
# extension=memcached.so
# extension=zip.so

# session.save_handler = memcached
# ;session.save_path = "youripd:11211"
# session.save_path = "/var/run/memcached/memcached.sock"


# memcached.sess_locking = 0
# memcached.sess_prefix = 'memc.sess.'


# zend_extension=opcache.so;
# opcache.interned_strings_buffer=32
# opcache.max_accelerated_files=32531
# opcache.memory_consumption=240
# opcache.revalidate_freq=300
# opcache.fast_shutdown=0
# opcache.enable_cli=0

# expose_php=Off
# date.timezone=Asia/Ho_Chi_Minh
# short_open_tag = On

