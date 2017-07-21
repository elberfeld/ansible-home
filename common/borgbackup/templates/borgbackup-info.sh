#!/bin/bash

export BORG_PASSPHRASE="{{repo_passphrase}}"
export BORG_RSH="ssh -i /srv/borgbackup/repo_sshkey"

#  Anzeige des Inhaltes im Borg Backup Archiv

BACKUPS=$(borg list $1 $2 $3 --info --show-rc --remote-path borg1 {{repo_url}})

echo "============================================="
echo "Backups List "
echo "$BACKUPS"

BACKUPS_LIST=$(echo "$BACKUPS" | awk '{print $1}')

for BACKUP in $BACKUPS_LIST; do

  echo "============================================="

  borg info $1 $2 $3 --info --show-rc --remote-path borg1 {{repo_url}}::$BACKUP

done

echo "============================================="


