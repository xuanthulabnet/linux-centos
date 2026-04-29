```
sudo dnf install mysql-server -y
sudo systemctl enable --now mysqld


mysql_secure_installation


```

```
echo "[mysqld]
port=3306
bind-address = 0.0.0.0
default_authentication_plugin=mysql_native_password
" >> /etc/my.cnf

RENAME USER 'root'@'localhost' TO 'root'@'%';

systemctl restart mysqld
systemctl status  mysqld
```

  