#!/bin/bash

set -eu

for mnt in "$@"; do
  if [[ ! "$mnt" =~ ^/exports/ ]]; then
    >&2 echo "Path to NFS export must be inside of the \"/exports/\" directory"
    exit 1
  fi
  mkdir -p $mnt
  chmod 777 $mnt
  echo "$mnt *(rw,sync,no_subtree_check,no_root_squash,fsid=0)" >> /etc/exports
done



set -e

#echo "#NFS Exports" > /etc/exports
#for mnt in "${mounts[@]}"; do
#    src=$(echo $mnt | awk -F':' '{ print $1 }')
#    mkdir -p $src
#    echo "$src *(rw,sync,no_subtree_check,no_root_squash,fsid=0)" >> /etc/exports
#done

# mkdir -p /share
# echo "/share-data *(rw,sync,no_subtree_check,no_root_squash,fsid=0)" >> /etc/exports

# exec /usr/lib/systemd/systemd --system --unit=rpcbind.service
# exec /usr/lib/systemd/systemd --system --unit=nfs-lock.service

# exec /usr/lib/systemd/systemd --system --unit=nfs-server.service


/sbin/rpcbind -w
/usr/sbin/exportfs -f
/usr/sbin/exportfs -au
/usr/sbin/exportfs -r
/usr/sbin/rpc.nfsd
/usr/sbin/rpc.idmapd  
/sbin/rpc.statd




mkdir -p /exports
chmod 755 /exports
echo "/exports/ *(rw,fsid=0,sync,no_subtree_check,no_root_squash)" >> /etc/exports
mount -t nfsd nfds /proc/fs/nfsd
exportfs -r
rpcbind
rpc.statd
rpc.nfsd -G 10 -N 2 -V 3
rpc.mountd -N 2 -V 3 --foreground -d all


docker run --rm -it --name nfs -p 2049:2049 -p 20048:20048/udp -p 111:111 --privileged abc 
docker run --rm -it --name nfs -p 2049:2049 -p 20048:20048/udp -p 111:111 --privileged xtnfsserver 
 
/usr/sbin/init


docker volume create --driver local \
    --opt type=nfs \
    --opt o=addr=172.17.0.2,rw \
    --opt device=:/exports \
    nfs


docker -it --rm -v nfs:/nfs busybox

