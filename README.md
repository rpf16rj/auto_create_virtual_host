# Script para automatizar configuração do Nginx

# Recursos
- Este scritp criar o arquivo .conf do Nginx que aponta o para algum serviço publicado em alguma porta no host. 
- Também permite que seja criado o certificado para que o serviço rode no domínio com HTTPS com certificado válido pelo Let's Encrypt. 

# Compatibilidade
- Ubuntu ou derivados Debian

# Recursos
- Configura automaticamente o arquivo de host virtual
- Gera o certificado SSL para o site

# Como usar: 

```bash
git clone https://github.com/rpf16rj/auto_create_virtual_host 

cd auto_create_virtual_host 

sudo chmod +x auto_host.sh 

sudo ./auto_host.sh
