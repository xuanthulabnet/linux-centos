#!/bin/bash
yum install kibana -y
systemctl enable kibana

echo 'server.host: 0.0.0.0' >> /etc/kibana/kibana.yml


systemctl start kibana

firewall-cmd --permanent --add-port=5601/tcp
firewall-cmd --permanent --add-port=5601/tcp
firewall-cmd --reload