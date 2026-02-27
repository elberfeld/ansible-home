#!/bin/bash

# Initialisierung der Borg Backup Archives
# Der SSH key aus /srv/borgbackup/repo_sshkey muss vorher auf den Backupserver übertragen werden 

export BORG_PASSPHRASE="{{repo_passphrase}}"
export BORG_RSH="ssh -o 'IdentitiesOnly yes' -i /srv/borgbackup/repo_sshkey"

if [ ! -e "/srv/borgbackup/{{ item.key }}/initialized" ]; then

  echo "Initialize Repo: {{ item.key }}"
  date > "/srv/borgbackup/{{ item.key }}/initialized"

  borg init $1 $2 $3 --info --show-rc --encryption=repokey {{ item.value.options }} {{ item.value.repo }}  
else
  
  echo "Repo already initialized: {{ item.key }}"

fi

