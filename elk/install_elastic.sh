#!/bin/bash
yum install java-1.8.0-openjdk-devel -y

echo '[elasticsearch-7.x]
name=Elasticsearch repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/7.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
' > /etc/yum.repos.d/elasticsearch.repo

yum install elasticsearch -y


echo 'network.host: 0.0.0.0
http.port: 9200
# thiết lập chỉ 1 server, hủy kiểm tra bootstrap
discovery.type: single-node' >> /etc/elasticsearch/elasticsearch.yml


systemctl enable elasticsearch.service
systemctl start elasticsearch.service

firewall-cmd --permanent --add-port=9200/tcp
firewall-cmd --permanent --add-port=9300/tcp
firewall-cmd --reload
