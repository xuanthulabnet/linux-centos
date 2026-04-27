```
sudo dnf update -y
sudo dnf install redis -y
sudo systemctl enable --now redis

```

CAU HINH

```
/etc/redis/redis.conf

# unixsocket /var/run/memcached/redis.sock
# unixsocketperm 777


# Chu y thu muc: /var/run/memcached/
mkdir /var/run/memcached/
chmod 777 /var/run/memcached/



systemctl restart redis
systemctl status redis

```

PHP EXT

```
sudo dnf install https://fedoraproject.org -y
sudo dnf install https://remirepo.net -y
sudo dnf install php-pecl-redis5 -y

```
