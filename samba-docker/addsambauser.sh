#!/bin/bash
useradd smbuser
groupadd smbgroup 
usermod -a -G smbgroup smbuser
smbpasswd -a smbuser
