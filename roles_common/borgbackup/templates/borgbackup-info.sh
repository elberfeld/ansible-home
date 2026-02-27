#!/bin/bash

export BORG_PASSPHRASE="{{repo_passphrase}}"
export BORG_RSH="ssh -o 'IdentitiesOnly yes' -i /srv/borgbackup/repo_sshkey"

#  Anzeige des Inhaltes in den Borg Backup Archiven

echo "============================================="
echo "Backups Repo Info: {{ item.key }} "

BACKUPS=$(borg list $1 $2 $3 --info --show-rc {{ item.value.options }} {{ item.value.repo }})

echo "$BACKUPS"

BACKUPS_LIST=$(echo "$BACKUPS" | awk '{print $1}')

for BACKUP in $BACKUPS_LIST; do

  echo "============================================="

  borg info $1 $2 $3 --info --show-rc {{ item.value.options }} {{ item.value.repo }}::$BACKUP

done

echo "============================================="


