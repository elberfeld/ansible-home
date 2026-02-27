#!/bin/bash

export BORG_PASSPHRASE="{{repo_passphrase}}"
export BORG_RSH="ssh -o 'IdentitiesOnly yes' -i /srv/borgbackup/repo_sshkey"

# Löschen eines Backups

echo "Available Backups: "

borg list $1 $2 $3 --info --show-rc {{ item.value.options }} {{ item.value.repo }}

echo "BackupName, followed by [ENTER]:"
read target

borg delete $1 $2 $3 --info --show-rc {{ item.value.options }} {{ item.value.repo }}::$target
