#!/bin/bash

  

read -p "User name to add: " user
user=${user:-user}

read -p "Password user to add: " passuser
passuser=${passuser:-passuser}

  
 
mysql -u root -p -e "CREATE USER '$user'@'localhost' IDENTIFIED WITH mysql_native_password BY '$passuser';
CREATE DATABASE $user;
GRANT ALL PRIVILEGES ON mydb.* TO '$user'@'localhost';"
 
 