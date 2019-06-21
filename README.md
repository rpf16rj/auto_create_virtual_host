# Script sh para criar automaticamente host virtual no Nginx e apontar para um container docker.

Esse script permite a criação do host virtual no Nginx e apontar para qualquer servidor web em execução no servidor.

# Requisitos
- Ubuntu ou derivados Debian
- Nginx instalado
- Certbot instalado

# Recursos
- Configura automaticamente o arquivo de host virtual
- Gera o certificado SSL para o site

# Como usar: 

git clone https://github.com/rpf16rj/auto_create_virtual_host 

sudo chmod +x auto_host.sh 

sudo ./auto_host.sh
