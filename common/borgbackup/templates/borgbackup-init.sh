#!/bin/bash

# Initialisierung der Borg Backup Archives
# Der SSH key aus /srv/borgbackup/repo_sshkey muss vorher auf den Backupserver übertragen werden 

export BORG_PASSPHRASE="{{repo_passphrase}}"
export BORG_RSH="ssh -i /srv/borgbackup/repo_sshkey"

{% for repo_url in borgbackup_repos %}

if [ ! -e "{{repo_url}}.initialized" ]; then

  echo "Initialize Repo: {{repo_url}}"
  date > "{{repo_url}}.initialized"

  borg init $1 $2 $3 --info --show-rc --remote-path borg1 --encryption=repokey {{repo_url}} 
else
  
  echo "Repo already initialized: {{repo_url}}"

fi

{% endfor %}
