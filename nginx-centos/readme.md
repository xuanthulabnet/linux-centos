# Sử dụng Nginx + PHP-FPM

## Tạo máy ảo CentOS7 có IP - 192.168.10.57
```
vagrant up
```
## Cài đặt vagrant-vbguest (shared folder)
```
vagrant plugin uninstall vagrant-vbguest

vagrant plugin install vagrant-vbguest --plugin-version 0.21

vagrant reload
```
