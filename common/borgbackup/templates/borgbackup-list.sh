#!/bin/bash

export BORG_PASSPHRASE="{{repo_passphrase}}"
export BORG_RSH="ssh -i /srv/borgbackup/repo_sshkey"

# Anzeige des Inhaltes im Borg Backup Archiv

borg list $1 $2 $3 --info --show-rc --remote-path borg1 {{repo_url}} 
