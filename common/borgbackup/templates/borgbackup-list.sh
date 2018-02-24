#!/bin/bash

export BORG_PASSPHRASE="{{repo_passphrase}}"
export BORG_RSH="ssh -i /srv/borgbackup/repo_sshkey"

# Anzeige des Inhaltes in den Borg Backup Archiven

{% for repo_url in borgbackup_repos %}

echo "===[ List Repo: {{repo_url}} ]============================================================"
borg list $1 $2 $3 --info --show-rc --remote-path borg1 {{repo_url}} 

{% endfor %}

