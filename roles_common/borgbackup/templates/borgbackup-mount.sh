#!/bin/bash

export BORG_PASSPHRASE="{{repo_passphrase}}"
export BORG_RSH="ssh -i /srv/borgbackup/repo_sshkey"

# Einhängen der Repos in /mnt/

echo "Directory to mount, followed by [ENTER]:"
read target

borg mount $1 $2 $3 --info --show-rc {{ item.value.options }} {{ item.value.repo }} $target

