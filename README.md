# - Atividade de Linux PB COMPASS UOL - ABRIL 2025 | DevSecOps -

## Este repositório faz parte da Atividade de Linux de monitoramento de um servidor web Nginx, juntamente com o Programa de Bolsas - DevSecOps do Time Compass.

> Este projeto demonstra como configurar um ambiente de monitoramento básico para um servidor Nginx em um sistema Linux.  
> Inclui scripts e arquivos de configuração úteis para monitoramento de disponibilidade, uso de recursos e integridade do serviço web.

# Resumo 
> Neste projeto, desenvolvi um sistema de monitoramento de servidor que envia notificações via Discord, a cada minuto, caso o serviço esteja indisponível.  
> O monitoramento foi implementado utilizando Shell Script, tendo como base um servidor Nginx, responsável por prover serviços web.  
> A comunicação com o Discord é feita através da tecnologia Webhook.  
> Para facilitar a transferência dos arquivos `.sh` e `.html` entre as máquinas, utilizei um servidor de arquivos Samba.

# 🐧 1 - Criação e configuração do ambiente Linux
![print 1](/imagens/image.png)

# 🐼 2 - Instalação e configuração do servidor de arquivos Samba

## 2.1 - Instalação 
```bash
apt-get install samba
```
![print 2](/imagens/image-2.png)

## 2.2 - Configuração 
```bash
/etc/samba/smb.conf
```
![print 3](/imagens/image-1.png)

# 🚀 3 - Instalação e configuração do servidor Web Nginx

## 3.1 - Instalação    
```bash
apt-get install nginx
```
![print 4](/imagens/image-3.png)

## 3.2 - Configuração 
```bash
/etc/nginx/sites-available/default
```
![alt text](/imagens/image-4.png)

## 🤠 3.3 - Nginx funcionando com êxito!
![print 5](/imagens/image-5.png)

# 4 - Criação e configuração do Webhook

## 4.1 - Criação do servidor para teste 
![print 6](/imagens/image-7.png)

## 4.2 - Criação do bot para mensagens
![print 7](/imagens/image-8.png)

# 💡 5 - Desenvolvimento da lógica de monitoramento

## 5.1 - Criação do script de monitoramento 
![print 8](/imagens/image-9.png)

```bash
#!/bin/bash
STATUS=$(curl -s -o /dev/null -w "%{http_code}" 192.168.1.12)

if [ "$STATUS" = "200" ]; then
    echo "SERVIDOR ON-LINE : $(date)"
    echo "Verificação feita em : $(date) Status : on-line"
else
    echo "SERVIDOR OFF-LINE : $(date)"
    echo "Verificação feita em : $(date) Status : off-line" >> /var/log/monitoramento.log

    curl -H "Content-Type: application/json" \
    -X POST \
    -d '{"embeds":[{
    "title":"SERVIDOR OFF-LINE",
    "description" : "O servidor está fora de operação",
    "color": 16711680 
    }]}' "$url_path"
fi
```

## 5.2 - Envio dos logs para o arquivo `/var/log/monitoramento.log`
![print 9](/imagens/image-10.png)

## 🥳 5.3 - Envio de mensagem ao servidor 
![print 10](/imagens/image-12.png)
