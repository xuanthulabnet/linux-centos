#!/bin/bash

sshuser=${sshuser:-sshuser}
password=${password:-pass}
sshgroup="sshgroup"

useradd $sshuser
groupadd $sshgroup
usermod -a -G $sshgroup $sshuser
echo "$sshuser:$password" | chpasswd

echo "user: $sshuser /gr $sshgroup";
echo "pass: $password";
 

mkdir -p /data
chmod 755 /data

chown $sshuser:$sshgroup /data

/usr/sbin/sshd -D


# docker plugin install --grant-all-permissions vieux/sshfs

#docker volume create -d vieux/sshfs -o sshcmd=<user@host:path> [-o IdentityFile=/root/.ssh/<key>] [-o port=<port>] [-o <any_sshfs_-o_option> ] sshvolume