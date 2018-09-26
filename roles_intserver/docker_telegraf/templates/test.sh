#!/bin/sh 

# Test Telegraf config and list data 
# Usage: ./test.sh <docker name>

docker-compose exec $1 telegraf --test
