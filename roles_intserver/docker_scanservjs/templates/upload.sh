#!/bin/bash

curl -T $1 -u paperless-consume:{{ webdav_user_pass }} http://{{ hostvars['webserver2'].int_ip4 }}:8081/$2 && rm $1
