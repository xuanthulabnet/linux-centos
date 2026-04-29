#!/bin/bash

sudo dnf config-manager --set-enabled crb
sudo dnf update -y
dnf install nano -y
yum update -y

nano /etc/ssh/sshd_config
    PubkeyAuthentication yes
    AuthorizedKeysFile .ssh/authorized_keys


nano ~/.ssh/authorized_keys
copy code /Users/xuanthulab/OneDrive/xdata/desk/7.\ ssh/authorized_keys 

touch ~/.ssh/id_rsa
nano ~/.ssh/id_rsa
copy code /Users/xuanthulab/OneDrive/xdata/desk/7.\ ssh/id_rsa_root 


# /home/abc                               700
# /home/abc/.ssh                          700
# /home/abc/.ssh/authorized_keys          600

# TAO SWAPFIILE QUAN TRONG
sudo fallocate -l 3G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# don cache truoc khi cai
sudo dnf clean all