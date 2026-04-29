#!/bin/bash
sudo dnf install epel-release -y
sudo dnf install certbot python3-certbot-nginx -y
# cap SSL
sudo certbot --nginx
# Tu dong gia han
sudo certbot renew --dry-run