#!/bin/bash
yum groupinstall " Development Tools"  -y
yum install expat-devel pcre pcre-devel openssl-devel -y
#https://github.com/apache/httpd/releases
apache="2.4.37"

#https://github.com/apache/apr/releases
apr="1.6.5"

#https://github.com/apache/apr-util/releases
util="1.6.1"

rm -rf httpd-$apache
wget https://github.com/apache/httpd/archive/$apache.tar.gz -O httpd-$apache.tar.gz
wget https://github.com/apache/apr/archive/$apr.tar.gz -O apr-$apr.tar.gz
wget https://github.com/apache/apr-util/archive/$util.tar.gz -O apr-util-$util.tar.gz

tar -xzf httpd-$apache.tar.gz
tar -xzf apr-$apr.tar.gz
tar -xzf apr-util-$util.tar.gz

mv  apr-$apr httpd-$apache/srclib/apr
mv  apr-util-$util httpd-$apache/srclib/apr-util
dirapache="httpd-$apache"
cd "${dirapache}"

./buildconf

"./configure" \
	"--prefix=/etc/httpd" \
	"--exec-prefix=/etc/httpd" \
	"--bindir=/usr/bin" \
	"--sbindir=/usr/sbin" \
	"--sysconfdir=/etc/httpd/conf" \
	"--with-ssl=/usr" \
	"--includedir=/usr/include/apache" \
	"--libexecdir=/usr/lib/apache" \
	"--libdir=/usr/lib/apache" \
	"--mandir=/usr/share/man" \
	"--datadir=/var/www" \
	"--localstatedir=/var" \
	"--with-included-apr" \
	"--with-mpm=event" \
	"--enable-so" \
	"--enable-authz_core" \
	"--enable-dir" \
	"--enable-deflate" \
	"--enable-unique-id" \
	"--enable-socache_shmcb" \
	"--enable-socache_dbm" \
	"--enable-proxy_fcgi" \
	"--enable-mods-static=most" \
	"--enable-ssl" \
	"--enable-rewrite" \
	"--enable-socache_memcache" \
	"--enable-proxy" \
	"--enable-expires" \
	"--enable-reqtimeout" \
	"--enable-proxy_http" \
	"--enable-headers" \
	"--disable-fcgid" \
	"--disable-authn_dbm" \
	"--disable-authn_anon" \
	"--disable-authz_dbm" \
	"--disable-authz_owner" \
	"--disable-cache" \
	"--disable-include" \
	"--disable-substitute" \
	"--disable-env" \
	"--disable-version" \
	"--disable-proxy_connect" \
	"--disable-proxy_ftp" \
	"--disable-proxy_ajp" \
	"--disable-proxy_balancer" \
	"--disable-status" \
	"--disable-autoindex" \
	"--disable-info" \
	"--disable-negotiation" \
	"--disable-actions" \
	"--disable-speling" \
	"--disable-userdir" \
	"--disable-cache_socache" \
	"--disable-proxy_scgi" \
	"--disable-proxy_fdpass" \
	"--disable-proxy_wstunnel" \
	"--disable-proxy_express" \
	"--disable-proxy_hcheck" \
	"--disable-authn_dbd" \
	"--disable-authn_socache" \
	"--disable-authn_core" \
	"--disable-authz_groupfile" \
	"--disable-authz_dbd" \
	"--disable-auth_form" \
	"--disable-auth_digest" \
	"--disable-allowmethods" \
	"--disable-file_cache" \
	"--disable-watchdog" \
	"--disable-macro" \
	"--disable-dbd" \
	"--disable-dumpio" \
	"--disable-buffer" \
	"--disable-ratelimit" \
	"--disable-reqtimeout" \
	"--disable-ext_filter" \
	"--disable-request" \
	"--disable-sed" \
	"--disable-log_debug" \
	"--disable-unique_id" \
	"--disable-remoteip" \
	"--disable-session" \
	"--disable-dav" \
	"--disable-dav-fs" \
	"--disable-dav-lock" \
	"--disable-suexec" \
	"--disable-session_cookie" \
	"--disable-session_dbd" \
	"--disable-access_compat" \
	"--disable-authn_file" \
	"--disable-authz_host" \
	"--disable-authz_user" \
	"--disable-auth_basic" \
	"--disable-logio" \
	"--disable-slotmem_shm"

make
make install

cat <<EOF >/etc/systemd/system/httpd.service
[Unit]
Description=The Apache HTTP Server
After=network.target

[Service]
Type=forking
ExecStart=/usr/sbin/httpd -k start
ExecReload=/usr/sbin/httpd -k graceful
ExecStop=/usr/sbin/httpd -k graceful-stop
PIDFile=/var/logs/httpd.pid
KillSignal=SIGCONT
PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start httpd
systemctl enable httpd

firewall-cmd --add-service=http --permanent
firewall-cmd --add-service=https --permanent
firewall-cmd --reload



