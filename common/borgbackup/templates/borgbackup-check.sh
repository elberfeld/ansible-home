#!/bin/bash

# Überprüfung der Backup Archive 

export BORG_PASSPHRASE="{{repo_passphrase}}"
export BORG_RSH="ssh -i /srv/borgbackup/repo_sshkey"


{% for repo_url in borgbackup_repos %}

echo "===[ Check Repo: {{repo_url}} ]============================================================"
borg check $1 $2 $3 --info --show-rc --remote-path borg1 {{repo_url}}

{% endfor %}