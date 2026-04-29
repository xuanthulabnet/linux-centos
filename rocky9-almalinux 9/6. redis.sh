
sudo dnf update -y
sudo dnf install redis -y
sudo systemctl enable --now redis
sudo systemctl start redis
sudo systemctl enable redis

sudo nano /etc/redis/redis.conf 
 
# unixsocket /etc/run/redis.sock
# unixsocketperm 777

# Chu y
# mkdir /etc/run
# chmod 777 /etc/run
