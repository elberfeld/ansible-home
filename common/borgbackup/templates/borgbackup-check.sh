#!/bin/bash

export BORG_PASSPHRASE="{{repo_passphrase}}"
export BORG_RSH="ssh -i /data/borgbackup/repo_sshkey"

# Überprüfung des Archives 
borg check $1 $2 $3 --info --show-rc --remote-path borg1 {{repo_url}}