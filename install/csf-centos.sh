#!/bin/bash

yum install wget bind-utils -y  & update -y
yum install perl-libwww-perl net-tools perl-LWP-Protocol-https -y

cd scr_csf & mkdir scr_csf
wget https://download.configserver.com/csf.tgz
tar -xzf csf.tgz
cd csf 
sh install.sh

#Disable default Firewall CentOS 7
#systemctl stop firewalld
#systemctl disable firewalld

csf -r
csf --lfd start

perl /usr/local/csf/bin/csftest.pl
