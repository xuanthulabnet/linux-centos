```
sudo dnf install mysql-server
sudo systemctl enable --now mysqld


mysql_secure_installation
```

```
echo "[mysqld]
port=3306
bind-address = 0.0.0.0
" >> /etc/my.cnf
```

 /etc/my.cnf
```
[mysqld]
default_authentication_plugin=mysql_native_password

```