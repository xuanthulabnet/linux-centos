## BUILD IMAGE ichte/samba
```
build.sh
```
## Run container
Map path to ```/home/data/```
Name container ```samba```
```
docker run -it -p 139:139 -p 145:145  -v $(pwd):/home/data/ --name samba ichte/samba
```
## Add User: smbuser
```
docker exec -it samba bash
addsambauser.sh
```
Restart container
```
docker restart samba
```
## Access file server (/home/data/)
```
smb://ip/mydata
```
Detail [samba](https://xuanthulab.net/su-dung-samba-de-tao-files-server-chia-se-qua-mang-bang-giao-thuc-smb.html)
