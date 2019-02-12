# Script sh para criar automaticamente host virtual no Nginx e apontar para um container docker.
This script enables the creation of virtual host in Nginx and automatically points to a docker container running on the server.

In order to work, you must have installed:

Nginx
sudo apt-get install nginx

Certbot
sut apt-get install certbot

It works only on Linux.

# Features
- Automates virtual host configuration
- Automate SSL configuration for your site

# Usage: 

git clone https://github.com/rpf16rj/auto_create_virtual_host 

sudo chmod +x auto_host.sh 

sudo ./auto_host.sh
