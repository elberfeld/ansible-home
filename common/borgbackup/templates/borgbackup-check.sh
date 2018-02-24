#!/bin/bash

# Überprüfung der Backup Archive 

export BORG_PASSPHRASE="{{repo_passphrase}}"
export BORG_RSH="ssh -i /srv/borgbackup/repo_sshkey"

echo "===[ Check Repo: {{ item.value.repo }} ]==="
borg check $1 $2 $3 --info --show-rc {{ item.value.options }} {{ item.value.repo }}

