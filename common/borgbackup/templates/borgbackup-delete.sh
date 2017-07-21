#!/bin/bash

export BORG_PASSPHRASE="{{repo_passphrase}}"
export BORG_RSH="ssh -i /srv/borgbackup/repo_sshkey"

# Löschen eines Backups

borg list $1 $2 $3 --info --show-rc --remote-path borg1 {{repo_url}}

echo "BackupName, followed by [ENTER]:"
read target

borg delete $1 $2 $3 --info --show-rc --remote-path borg1 {{repo_url}}::$target
