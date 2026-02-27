#!/bin/bash

export BORG_PASSPHRASE="{{repo_passphrase}}"
export BORG_RSH="ssh -o 'IdentitiesOnly yes' -i /srv/borgbackup/repo_sshkey"

# Anzeige des Inhaltes in den Borg Backup Archiven

echo "===[ List Repo: {{ item.key }} ]==="
borg list $1 $2 $3 --info --show-rc {{ item.value.options }} {{ item.value.repo }} 


