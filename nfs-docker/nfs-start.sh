#!/bin/bash
mkdir -p /data
chmod 755 /data
# echo "/exports/ *(rw,fsid=0,insecure,no_subtree_check,sync)" >> /etc/exports
echo "/data/ *(rw,fsid=0,sync,no_subtree_check,no_root_squash)" >> /etc/exports


mount -t nfsd nfds /proc/fs/nfsd
exportfs -r
rpcbind
rpc.statd -d
rpc.nfsd -G 10 -N 2 -V 3
rpc.mountd -N 2 -V 3 --foreground -d all
# -d all

