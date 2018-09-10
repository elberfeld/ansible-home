#!/bin/bash

export BORG_PASSPHRASE="{{repo_passphrase}}"
export BORG_RSH="ssh -i /srv/borgbackup/repo_sshkey"
export BACKUP_DATE=`date +%Y-%m-%d_%H_%M`

# Ausführung der Backups
# anschließend Bereinigung 
# abschließend Integritätscheck 

echo "===[ Create Backup: {{ item.value.repo }} ]===" \
&& \
borg create $1 $2 $3 --info --show-rc --stats --compression {{ item.value.compression }} {{ item.value.options }} {{ item.value.repo }}::$BACKUP_DATE \
{% for directory in borgbackup_directories %}
{{ directory }} \
{% endfor %} \
{% if item.value.directories is defined %}
  {% for directory in item.value.directories %}
  {{ directory }} \
  {% endfor %} \
  {% endif %}
&& \
echo "===[ Prune old Backups: {{ item.value.repo }} ]===" \
&& \
borg prune $1 $2 $3 --info --show-rc --list {{ item.value.prune }} {{ item.value.options }} {{ item.value.repo }} \
&& \
echo "===[ Check Repo: {{ item.value.repo }} ]===" \
&& \
borg check $1 $2 $3 --info --show-rc {{ item.value.options }} {{ item.value.repo }} \
&& \
date > "/srv/borgbackup/{{ item.key }}/lastbackup"
