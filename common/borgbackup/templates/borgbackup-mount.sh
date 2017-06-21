#!/bin/bash

export BORG_PASSPHRASE="{{repo_passphrase}}"
export BORG_RSH="ssh -i /data/borgbackup/repo_sshkey"

# Einhängen eines Backups nach /mnt/

echo -n 'Mounting to: /mnt'
borg mount $1 $2 $3 --info --show-rc --remote-path borg1 {{repo_url}} /mnt/
