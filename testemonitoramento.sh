#!/bin/bash
STATUS=$(curl -s -o /dev/null -w "%{http_code}" 192.168.1.12)

  if [ "$STATUS" = "200" ]; then
     echo "SERVIDOR ON-LINE : $(date)"
     echo "verificação feita em : $(date) Status : on-line"

  else
     echo "SERVIDOR OFF-LINE : $(date)"
     echo "verificação feita em : $(date) Status : off-line" >> /var/log/monitoramento.log
	curl -H "Content-Type: application/json" \
  -X POST \
  -d '{"embeds":[{
	"title":"SERVIDOR OFF-LINE",
	"description" : "O servidor está fora de operação",
	"color": 16711680 
}]}'   "$url_path"
fi




