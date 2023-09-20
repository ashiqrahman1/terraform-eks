#!/bin/bash
yum update -y
yum install httpd -y
systemctl enable --now httpd
echo "This is working" > /var/www/html/index.html
mkdir /var/www/html/app1/
echo "This is working from App1" > /var/www/html/app1/index.html