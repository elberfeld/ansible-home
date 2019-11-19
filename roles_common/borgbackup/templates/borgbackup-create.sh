#!/bin/bash

export BORG_PASSPHRASE="{{repo_passphrase}}"
export BORG_RSH="ssh -i /srv/borgbackup/repo_sshkey"
export BACKUP_DATE=`date +%Y-%m-%d_%H_%M`
export LAST_BACKUPS_PROM="/var/lib/prometheus/node-exporter/lastbackup.prom"

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
echo "===[ write: /srv/rsyncbackup/{{ item.key }}/lastbackup ]===" \
&& \
date > "/srv/borgbackup/{{ item.key }}/lastbackup" \
&& \
echo "===[ add value to: $LAST_BACKUPS_PROM ]===" \
&& \
touch $LAST_BACKUPS_PROM \
&& \
sed -i '/borgbackup_lastbackup{repo="{{ item.key }}"}/d' $LAST_BACKUPS_PROM \
&& \
echo "borgbackup_lastbackup{repo=\"{{ item.key }}\"} $(date +%s)" >> $LAST_BACKUPS_PROM \
&& \
echo "===[ send alerta heartbeat ]===" \
&& \
/srv/alerta_heartbeat/send_service_heartbeat.sh {{ item.value.heartbeat_timeout }} borg@{{ item.key }} \
&& \
echo "===[ DONE ]===" 
