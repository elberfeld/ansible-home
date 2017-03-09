#!/bin/bash

# Host Keys erzeugen 
if [ ! -f /etc/ssh/keys/ssh_host_rsa_key ]
then
    ssh-keygen -f /etc/ssh/keys/ssh_host_rsa_key -N '' -t rsa
fi

if [ ! -f /etc/ssh/keys/ssh_host_dsa_key ]
then
    ssh-keygen -f /etc/ssh/keys/ssh_host_dsa_key -N '' -t dsa
fi

if [ ! -f /etc/ssh/keys/ssh_host_ecdsa_key ]
then
    ssh-keygen -f /etc/ssh/keys/ssh_host_ecdsa_key -N '' -t ecdsa
fi

if [ ! -f /etc/ssh/keys/ssh_host_ed25519_key ]
then
    ssh-keygen -f /etc/ssh/keys/ssh_host_ed25519_key -N '' -t ed25519
fi

# Authorized Keys explizit absichern 
chmod 755 /var/www/.ssh/authorized_keys
chown root:root /var/www/.ssh/authorized_keys

# SSHD starten 
/usr/sbin/sshd -D 2>&1 &

# NGINX Starten 
nginx -g "daemon off;"

