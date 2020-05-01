## BUILD IMAGE ichte/samba
Pull image:
```
docker pull ichte/samba
```
Or build from Dockerfile
```
build.sh
```

## Run container
Map path host  ```/path-host/``` to share volume, user `smbuser`,
password `123456`
```
docker run -it -p 139:139 -p 145:145 -v /path-host/:/data/ -e smbuser=smbuser -e password=123456 --name samba ichte/samba
```
 
 
## Access file server (/home/data/)
```
smb://ip/data
```

## Create Volume
```
docker volume create \
     --driver local \
     --opt type=cifs \
     --opt device=//IP/data \
     --opt o=username=smbuser,password=1234567,file_mode=0777,dir_mode=0777 \
     --name smb
```
### Create Volume in `docker-compose.yml`
```
volumesmb:
   driver: local
   driver_opts: 
    type: cifs
    device: //192.168.1.5/data
    o: "username=smbuser,password=1234567,file_mode=0777,dir_mode=0777"
```


Detail [samba](https://xuanthulab.net/su-dung-samba-de-tao-files-server-chia-se-qua-mang-bang-giao-thuc-smb.html)
