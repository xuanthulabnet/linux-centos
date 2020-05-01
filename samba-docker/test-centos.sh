#!/bin/bash
# Run on CentOS Container
#   
IP = 192.168.0.102

yum update -y
yum -y install samba-client cifs-utils samba-common -y

mkdir -p /mnt/mydata                # Tạo thư mục để Mount
groupadd --gid 2000 smbgroup        # Thêm một Group giống tên group trên Server
usermod -aG smbgroup root           # Gán group cho user (login) ví dụ root

smbclient -L //$IP/data -U smbuser
mount -t cifs -o user=smbuser,password=pass //192.168.0.102/data  /mnt/mydata



