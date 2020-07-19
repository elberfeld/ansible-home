#!/bin/sh 

# Compile Image manual 
# Usage: ./compile.sh <config.yml>
docker run --rm -v "{{ basedir }}/config:/config" -it esphome/esphome $1 compile
