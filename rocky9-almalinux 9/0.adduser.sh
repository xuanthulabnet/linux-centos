#!/bin/bash

sudo adduser username

mkdir -p /home/devuser/.ssh
chmod 700 /home/devuser/.ssh
nano /home/devuser/.ssh/authorized_keys
chmod 600 /home/devuser/.ssh/authorized_keys
chown -R devuser:devuser /home/devuser/.ssh

# Nginx 
chmod 711 user-directory 