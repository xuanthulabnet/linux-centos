#!/bin/bash
#Install Samba - https://www.samba.org/
# PORTS TCP 139, 445
# https://wiki.samba.org/index.php/Distribution-specific_Package_Installation

# Server Samba
yum update -y
yum install samba -y
#yum install samba samba-client samba-common -y

# Client Samba
yum update -y
yum -y install samba-client cifs-utils samba-common -y

# vi /etc/samba/smb.conf

# [Anonymous]
# path = /samba/publicshare/
# browsable =yes
# writable = yes
# guest ok = yes
# read only = no

# smbd
# smbcontrol smbd shutdown
# ps -A | grep smb

# mkdir -p /samba/publicshare/
# chmod -R 0755 /samba/publicshare/
# chown -R nobody:nobody /samba/publicshare/groupadd smbgroup                       # Tạo group smbgroup


# mkdir -p /home/mydata/
# chown -R testuser:smbgroup /home/mydata/
# chmod -R 0770 /home/mydata/
# chcon -t samba_share_t /home/mydata/


mkdir -p /mnt/mydata
groupadd --gid 2000 smbgroup
usermod -aG smbgroup root

smbclient -L //192.168.1.5/Mydata -U testuser

mount -t cifs -o user=testuser,password=123456 //192.168.1.5/Mydata  /mnt/mydata

  --cap-add SYS_ADMIN \
  --cap-add DAC_READ_SEARCH \

# Ubuntu:
apt update -y
apt upgrade -y
apt install samba vim -y


# Dirver
docker volume create \
     --driver local \
     --opt type=cifs \
     --opt device=//192.168.1.5/Mydata \
     --opt o=username=testuser,password=123456,file_mode=0777,dir_mode=0777 \
     --name smb

docker service create --replicas 5 -p 8888:80 --name website --mount source=smb,target=/app 192.168.99.107:5000/httpdtest:latest

