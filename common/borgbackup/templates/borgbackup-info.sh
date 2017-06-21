#!/bin/bash

export BORG_PASSPHRASE="{{repo_passphrase}}"
export BORG_RSH="ssh -i /data/borgbackup/repo_sshkey"

#  Anzeige des Inhaltes im Borg Backup Archiv

borg list $1 $2 $3 --info --show-rc --remote-path borg1 {{repo_url}}

echo "BackupName, followed by [ENTER]:"
read target

borg info $1 $2 $3 --info --show-rc --remote-path borg1 {{repo_url}}::$target
