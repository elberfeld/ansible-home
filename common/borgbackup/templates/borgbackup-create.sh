#!/bin/bash

export BORG_PASSPHRASE="{{repo_passphrase}}"
export BORG_RSH="ssh -i /data/borgbackup/repo_sshkey"

# Ausführung des Backups
# anschließend Bereinigung 
# abschließend Integritätscheck 

borg create $1 $2 $3 --info --show-rc --remote-path borg1 --stats --compression lzma,2 {{repo_url}}::`date +%Y-%m-%d_%H_%M` \
{% for directory in borgbackup_directories %}
{{ directory }} \
{% endfor %}
&& \
borg prune $1 $2 $3 --info --show-rc --list {{repo_url}} \
{% for prune in borgbackup_prune %}
{{ prune }} \
{% endfor %}
&& \
borg check $1 $2 $3 --info --show-rc {{repo_url}}
