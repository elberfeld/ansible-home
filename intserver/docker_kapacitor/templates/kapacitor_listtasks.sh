#!/bin/sh
# Show Kapacitor Tasks
# Usage: ./kapacitor_listtasks.sh 

docker-compose exec app kapacitor list tasks
