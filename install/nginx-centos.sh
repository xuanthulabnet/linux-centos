#!/bin/bash

# Install Nginx
yum install epel-release -y
yum install nginx -y
systemctl start nginx
systemctl enable nginx

# Allow firewall
firewall-cmd --permanent --zone=public --add-service=http 
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload

#https://gist.github.com/denji/8359866


