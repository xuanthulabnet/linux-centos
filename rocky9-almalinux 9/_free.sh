sudo dnf clean all
sudo rm -rf /var/cache/dnf/*

# Xem Big log
du -h /var/log | sort -rh | head
# xoa log cu
sudo journalctl --vacuum-time=3d

# Docker
docker system df
docker system prune -a -f

# MySQL 
du -h /var/lib/mysql | sort -rh | head

#Tim file dung luong lon
find / -type f -size +100M 2>/dev/null

#Xoa package ko dung den
sudo dnf autoremove -y

#TOol
sudo dnf install ncdu -y
ncdu /