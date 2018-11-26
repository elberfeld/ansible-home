#!/bin/sh 

curl -XPOST {{ alerta.url }}/api/heartbeat \
-H 'Authorization: Key {{ alerta_api_key }}' \
-H 'Content-type: application/json' \
-d '{
  "origin": "{{ inventory_hostname }} - SYSTEM",
  "tags": [
    "server"
  ],
  "timeout": 300
}'
