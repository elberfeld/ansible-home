#!/bin/sh 

curl -XPOST {{ alerta.url }}/api/heartbeat \
-H 'Authorization: Key {{ alerta_api_key }}' \
-H 'Content-type: application/json' \
-d '{
  "origin": "{{ inventory_hostname }} - '$2'",
  "tags": [
    "service"
  ],
  "timeout": '$1'
}'
