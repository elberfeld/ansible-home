#!/bin/bash

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
date > "/srv/rsyncbackup/{{ job.key }}/lastbackup" \
&& \
echo "rsyncbackup_lastbackup{repo=\"{{ job.key }}\"} $(date +%s)" > "/srv/prometheus-node-exporter/rsyncbackup_{{ job.key }}.prom" \
&& \
/srv/alerta_heartbeat/send_service_heartbeat.sh {{ job.value.heartbeat_timeout }} rsync@{{ job.key }}
