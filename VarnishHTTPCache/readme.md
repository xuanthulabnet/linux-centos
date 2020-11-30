# Example use Vanish - nginx - php-fpm

https://xuanthulab.net/su-dung-varnish-cache-de-tang-toc-ung-dung-web.html

## Create VM (macOS) - 192.168.10.56
```
vagrant up
```
## Install vagrant-vbguest (shared folder)
```
vagrant plugin uninstall vagrant-vbguest

vagrant plugin install vagrant-vbguest --plugin-version 0.21

vagrant reload
```
add hosts
```
192.168.10.56 testvanish1.net
```


## Install netstat CentOS 7
```
yum install net-tools -y

# check ports / services
netstat -pnltu
```

## Install PHP-FPM (9200), Nginx (80), Vanish (6081)
```
install-nginx.sh
install-php-fpm80.sh
install-vanish.sh
```


# Config Varnish as a reverse proxy for Nginx
```
vi /etc/nginx/nginx.conf
```
Update block
```
.....
server {
        listen       127.0.0.1:8080 default_server;
        # listen  [::] 8080 default_server;
        ....
}
```
```
systemctl restart nginx
```

## Varnish configuration
```
vi /etc/varnish/default.vcl
```
Update
```
backend default {
     .host = "127.0.0.1";
     .port = "8080";
 }
```
```
vi /etc/varnish/varnish.params

VARNISH_LISTEN_ADDRESS=127.0.0.1
VARNISH_LISTEN_PORT=6081
```
```
systemctl restart varnish
```
Check logs
```
varnishncsa
```

