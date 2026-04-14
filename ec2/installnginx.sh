#!/bin/bash

sudo apt update
sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

echo "Welcome to Terraform Tutorial" > /var/www/html/index.html