#!/bin/bash
# BUILD PHP - FPM FROM SOURCE
yum install autoconf libtool libmemcached-devel re2c bison /
    libxml2-devel bzip2-devel libcurl-devel libpng-devel /
	libicu-devel gcc-c++ libmcrypt-devel libwebp-devel libjpeg-devel openssl-devel -y

#https://github.com/php/php-src/releases


read -p "User run php-fpm (apache): " user
user=${user:-apache}

read -p "Group run php-fpm (apache): " group
group=${group:-apache}

read -p "PHP Version (7.3.11): " phpver
phpver=${phpver:-7.3.11}

read -p "PHP PATH (/usr/local/php7): " prefix
prefix=${prefix:-/usr/local/php7}
  
dircodephp="php-src-php-$phpver"
configpath="$prefix/etc"
 

rm -rf $dircodephp

curl -O -L https://github.com/php/php-src/archive/php-$phpver.tar.gz
tar -zxvf php-$phpver.tar.gz

extdir=$dircodephp/ext

cd "${extdir}"
#EXT MEMCACHED memcached 3.0.4
pecl download memcached
tar -xvf memcached-3.1.4.tgz
mv memcached-3.1.4 memcached



cd ..
#cd "${dircodephp}"




./buildconf --force

./configure \
	--prefix=$prefix \
	--exec-prefix=$prefix \
	--with-gd \
	--with-gettext \
	--with-libxml-dir=/usr/local/lib \
	--with-config-file-path=$configpath \
	--with-apxs2=/usr/bin/apxs \
	--with-kerberos \
	--with-openssl \
	--with-mhash \
	--with-pear \
	--with-zlib \
	--with-zlib-dir=/usr/local/lib \
	--with-png-dir=/usr/lib64 \
	--with-jpeg-dir=/usr/lib64 \
	--enable-zip \
	--enable-exif \
	--enable-bcmath \
	--enable-calendar \
	--enable-memcached \
	--enable-redis \
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
;listen = /usr/local/php/var/run/www-php-fpm.sock
listen = 127.0.0.1:9000
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

cp ./sapi/fpm/php-fpm.service /etc/systemd/system/
chmod +x /etc/systemd/system/php-fpm.service
systemctl enable php-fpm.service
systemctl start php-fpm.service

service httpd restart

	
echo "
SetHandler \"proxy:fcgi://127.0.0.1:9000\"
" >> /etc/httpd/conf/httpd.conf