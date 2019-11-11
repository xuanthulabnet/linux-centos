#!/bin/bash
docker image rm ichte/nfs
docker build -t ichte/nfs -f Dockerfile .


# docker run --rm -it --name nfs -p 2049:2049 -p 20048:20048/udp --privileged ichte/nfs 

docker volume create --driver local \
    --opt type=nfs \
    --opt o=addr=192.168.0.102,rw \
    --opt device=:/data \
    nfs
 
# docker run -it --rm -v nfs:/nfs busybox
