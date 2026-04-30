#!/bin/bash

sudo adduser username

mkdir -p /home/username/.ssh
chmod 700 /home/username/.ssh
nano /home/username/.ssh/authorized_keys
chmod 600 /home/username/.ssh/authorized_keys
chown -R username:username /home/username/.ssh
chmod 600 /home/username/.ssh/id_rsa

# Nginx 
chmod 711 user-directory 

sudo dnf install -y git
git --version

git config --global user.name "xuanthulab"
git config --global user.email "xuanthulab.net@gmail.com"
git config --list


##FIX VS CODE SERVER
sudo dnf install -y tar gzip bash
sudo dnf install -y glibc libstdc++ libgcc
sudo dnf install -y tar gzip bash curl
sudo dnf install -y glibc libstdc++ libgcc
rm -rf ~/.vscode-server