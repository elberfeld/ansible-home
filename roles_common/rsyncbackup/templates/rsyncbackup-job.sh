#!/bin/bash

export LAST_BACKUPS_PROM="/var/lib/prometheus/node-exporter/lastbackup.prom"

echo "===[ START RSync Job: {{ job.key }} ]===" \
&& \
/usr/bin/rsync --password-file=/srv/rsyncbackup/{{ job.key }}/rsync_password --verbose --archive --delete \
{% if job.value.includes is defined %} \
  {% for include in job.value.includes %}
  --include="{{ include }}" \
  {% endfor %} \
{% endif %} \
{% if job.value.excludes is defined %} \
  {% for exclude in job.value.excludes %}
  --exclude="{{ exclude }}" \
  {% endfor %} \
{% endif %} \
{{ job.value.options }} \
{{ job.value.basedir }} \
{{ job.value.target }} \
&& \
echo "===[ END RSync Job: {{ job.key }} ]===" \
&& \
echo "===[ write: /srv/rsyncbackup/{{ job.key }}/lastbackup ]===" \
&& \
date > "/srv/rsyncbackup/{{ job.key }}/lastbackup" \
&& \
echo "===[ add value to: $LAST_BACKUPS_PROM ]===" \
&& \
touch $LAST_BACKUPS_PROM \
&& \
sed -i '/rsyncbackup_lastbackup{repo="{{ job.key }}"}/d' $LAST_BACKUPS_PROM \
&& \
echo "rsyncbackup_lastbackup{repo=\"{{ job.key }}\"} $(date +%s)" >> $LAST_BACKUPS_PROM \
&& \
echo "===[ send alerta heartbeat ]===" \
&& \
/srv/alerta_heartbeat/send_service_heartbeat.sh {{ job.value.heartbeat_timeout }} rsync@{{ job.key }} \
&& \
echo "===[ DONE ]===" 
