#!/bin/bash

sudo dnf update -y
sudo dnf install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl status nginx

sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload

# Test config (/etc/nginx/nginx.conf)
#     sudo nginx -t
#     sudo systemctl reload nginx

#    /usr/share/nginx/html





# ##### TEST SSL HOST
#     sudo mkdir -p /etc/nginx/ssl
#     cd /etc/nginx/ssl

#     sudo openssl req -x509 -nodes -days 365 \
#     -newkey rsa:2048 \
#     -keyout nginx.key \
#     -out nginx.crt

#     ---- /etc/nginx/nginx.conf
#     server {
#         listen 443 ssl;
#         server_name localhost;

#         ssl_certificate /etc/nginx/ssl/nginx.crt;
#         ssl_certificate_key /etc/nginx/ssl/nginx.key;

#         ssl_protocols TLSv1.2 TLSv1.3;
#         ssl_ciphers HIGH:!aNULL:!MD5;

#         root /usr/share/nginx/html;
#         index index.html;
#     }
#     sudo nginx -t
#     sudo systemctl reload nginx


### TEST PHP FPM 
        # --- /usr/share/nginx/html/test.php
        # <?php 
        # echo "HTML FROM PHP ECHO "; echo date("d/M/Y");
        # ?>
        # ---/etc/nginx/nginx.conf
        # server {
        #         listen       80;
        #         listen       [::]:80;
        #         server_name  _;
        #         root         /usr/share/nginx/html;

        #         # Load configuration files for the default server block.
        #         include /etc/nginx/default.d/*.conf;

        #         error_page 404 /404.html;
        #         location = /404.html {
        #         }

        #         error_page 500 502 503 504 /50x.html;
        #         location = /50x.html {
        #         }
        #     }

        #     server {
        #     listen 443 ssl http2;
        #     listen  [::]:443 default_server;
        #     server_name localhost;

        #     ssl_certificate /etc/nginx/ssl/nginx.crt;
        #     ssl_certificate_key /etc/nginx/ssl/nginx.key;

        #     ssl_protocols TLSv1.2 TLSv1.3;
        #     ssl_ciphers HIGH:!aNULL:!MD5;

        #     root /usr/share/nginx/html;
        #     index index.html;


        #     location / {
        #         try_files $uri $uri/ /index.php$is_args$query_string;
        #     }

        #     location ~ \.php$ {
                

        #         try_files $uri =404;
        #         fastcgi_split_path_info ^(.+\.php)(/.+)$;
        #         fastcgi_pass unix:/run/php-fpm/www.sock;
        #         fastcgi_index index.php;
        #         include fastcgi_params;
        #         fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        #         fastcgi_param PATH_INFO $fastcgi_path_info;
        #         fastcgi_param REMOTE_ADDR $http_x_real_ip;
                
        #     }
        # }


    