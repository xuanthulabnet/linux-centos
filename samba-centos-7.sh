#!/bin/bash
#Install Samba - https://www.samba.org/
# PORTS TCP 139, 445
# https://wiki.samba.org/index.php/Distribution-specific_Package_Installation
yum update -y
yum install samba -y
#yum install samba samba-client samba-common -y

vi /etc/samba/smb.conf

[Anonymous]
path = /samba/anonymous
browsable =yes
writable = yes
guest ok = yes
read only = no

smbd -FS -d 2 < /dev/null
    --no-process-group
smbcontrol smbd shutdown
ps -A | grep smb

mkdir -p /samba/anonymous
chmod -R 0755 anonymous/
chown -R nobody:nobody anonymous/

