#!/bin/bash
# Versão 1.0.
# Autor: rpf16rj

echo ''
echo '=========================================='
echo ' Script de criação automática '
echo ' de host virtual com SSL, Nginx e Docker. '
echo '=========================================='
echo ''
echo 'Digite o domínio para o host virtual:' 
read dominio
echo ''
echo '...'
echo 'Vamos criar o seu host virtual...'
echo ''
echo 'Informe a porta do container que será apontada para este domínio: ' 
read port
echo ''
echo 'Criando arquivo sites-enabled do seu site...'
echo ''
echo "##
# You should look at the following URL's in order to grasp a solid understanding
# of Nginx configuration files in order to fully unleash the power of Nginx.
# http://wiki.nginx.org/Pitfalls
# http://wiki.nginx.org/QuickStart
# http://wiki.nginx.org/Configuration
#
# Generally, you will want to move this file somewhere, and start with a clean
# file but keep this around for reference. Or just disable in sites-enabled.
#
# Please see /usr/share/doc/nginx-doc/examples/ for more detailed examples.
##

# Default server configuration
#
server {
    server_name $dominio;

    location / {
        proxy_pass http://localhost:$port/;
        proxy_set_header Host $dominio;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}

server {
    listen 80;
    listen [::]:80;
}
" >> "/etc/nginx/sites-available/$dominio"

ln -s /etc/nginx/sites-available/$dominio /etc/nginx/sites-enabled/$dominio
echo ''
echo 'Recarregando configuração do NGINX...'
echo ''
sudo service nginx reload
echo ''

echo 'Deseja rodar o Lets Encrypt para gerar o certificado do seu domínio? É necessário que seu domínio já esteja com o DNS apontando para o IP do servidor, caso contrário causará erro.'
echo 'Digite s ou n'
echo ''
read resp

if [[ "$resp" = "s" ]] ; then

echo 'Criando SSL com Lets Encrypt...'

sudo service nginx stop

sudo certbot certonly --standalone --preferred-challenges http -d $dominio

sudo rm /etc/nginx/sites-available/$dominio /etc/nginx//sites-enabled/$dominio

echo "##
# You should look at the following URL's in order to grasp a solid understanding
# of Nginx configuration files in order to fully unleash the power of Nginx.
# http://wiki.nginx.org/Pitfalls
# http://wiki.nginx.org/QuickStart
# http://wiki.nginx.org/Configuration
#
# Generally, you will want to move this file somewhere, and start with a clean
# file but keep this around for reference. Or just disable in sites-enabled.
#
# Please see /usr/share/doc/nginx-doc/examples/ for more detailed examples.
##

# Default server configuration
#
server {
    server_name $dominio;

    location / {
        proxy_pass http://localhost:$port/;
        proxy_set_header Host $dominio;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }

    listen [::]:443 ssl; # managed by Certbot
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/$dominio/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/$dominio/privkey.pem; # managed by Certbot
}

server {
    if (\$host = $dominio) {
        return 301 https://$host$request_uri;
    } # managed by Certbot

    listen 80;
    listen [::]:80;

    server_name $dominio;
    return 444; # managed by Certbot
}
" >> "/etc/nginx/sites-available/$dominio"

ln -s /etc/nginx/sites-available/$dominio /etc/nginx/sites-enabled/$dominio
echo ''

fi

echo "Sucesso! Host virtual $dominio criado e apontando para a porta $port."

exit