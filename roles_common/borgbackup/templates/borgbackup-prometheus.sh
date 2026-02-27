#!/bin/bash

export BORG_PASSPHRASE="{{repo_passphrase}}"
export BORG_RSH="ssh -o 'IdentitiesOnly yes' -i /srv/borgbackup/repo_sshkey"

# Metrics output file in the prometheus node-exporter directory 
PROM_FILE="/var/lib/prometheus/node-exporter/borgbackup.prom"

#  Borgbackup statistiken für Prometheus erstellen 

function calc_bytes {
	NUM=$1
	UNIT=$2
	
	case "$UNIT" in
		kB)
			echo $NUM | awk '{ print $1 * 1024 }'
			;;
		MB)
			echo $NUM | awk '{ print $1 * 1024 * 1024 }'
			;;
		GB)
			echo $NUM | awk '{ print $1 * 1024 * 1024 * 1024 }'
			;;
		TB)
			echo $NUM | awk '{ print $1 * 1024 * 1024 * 1024 * 1024 }'
			;;
	esac
}

# create temp file 
TMP_FILE=$(mktemp)

echo "borgbackup_repos_count {{ borgbackup_repos|length }}" > $TMP_FILE

{% for repo in borgbackup_repos %}

BACKUPS=$(borg list {{ borgbackup_repos[repo].options }} {{ borgbackup_repos[repo].repo }})
BACKUPS_LIST=$(echo "$BACKUPS" | awk '{print $1}')
COUNTER=0

for BACKUP in $BACKUPS_LIST; do

  COUNTER=$((COUNTER+1))

done

BORG_INFO=$(borg info {{ borgbackup_repos[repo].options }} {{ borgbackup_repos[repo].repo }}::$BACKUP)

echo "borgbackup_count{repo=\"{{ repo }}\"} $COUNTER" >> $TMP_FILE
echo "borgbackup_files{repo=\"{{ repo }}\"} $(echo "$BORG_INFO" | grep "Number of files" | awk '{print $4}')" >> $TMP_FILE
echo "borgbackup_chunks_unique{repo=\"{{ repo }}\"} $(echo "$BORG_INFO" | grep "Chunk index" | awk '{print $3}')" >> $TMP_FILE
echo "borgbackup_chunks_total{repo=\"{{ repo }}\"} $(echo "$BORG_INFO" | grep "Chunk index" | awk '{print $4}')" >> $TMP_FILE

# byte size calculation 
LAST_SIZE=$(calc_bytes $(echo "$BORG_INFO" |grep "This archive" |awk '{print $3}') $(echo "$BORG_INFO" |grep "This archive" |awk '{print $4}'))
LAST_SIZE_COMPRESSED=$(calc_bytes $(echo "$BORG_INFO" |grep "This archive" |awk '{print $5}') $(echo "$BORG_INFO" |grep "This archive" |awk '{print $6}'))
LAST_SIZE_DEDUP=$(calc_bytes $(echo "$BORG_INFO" |grep "This archive" |awk '{print $7}') $(echo "$BORG_INFO" |grep "This archive" |awk '{print $8}'))
TOTAL_SIZE=$(calc_bytes $(echo "$BORG_INFO" |grep "All archives" |awk '{print $3}') $(echo "$BORG_INFO" |grep "All archives" |awk '{print $4}'))
TOTAL_SIZE_COMPRESSED=$(calc_bytes $(echo "$BORG_INFO" |grep "All archives" |awk '{print $5}') $(echo "$BORG_INFO" |grep "All archives" |awk '{print $6}'))
TOTAL_SIZE_DEDUP=$(calc_bytes $(echo "$BORG_INFO" |grep "All archives" |awk '{print $7}') $(echo "$BORG_INFO" |grep "All archives" |awk '{print $8}'))

echo "borgbackup_last_size{repo=\"{{ repo }}\"} $LAST_SIZE" >> $TMP_FILE
echo "borgbackup_last_size_compressed{repo=\"{{ repo }}\"} $LAST_SIZE_COMPRESSED" >> $TMP_FILE
echo "borgbackup_last_size_dedup{repo=\"{{ repo }}\"} $LAST_SIZE_DEDUP" >> $TMP_FILE
echo "borgbackup_total_size{repo=\"{{ repo }}\"} $TOTAL_SIZE" >> $TMP_FILE
echo "borgbackup_total_size_compressed{repo=\"{{ repo }}\"} $TOTAL_SIZE_COMPRESSED" >> $TMP_FILE
echo "borgbackup_total_size_dedup{repo=\"{{ repo }}\"} $TOTAL_SIZE_DEDUP" >> $TMP_FILE

{% endfor %}

# move temp file to output file 
mv $TMP_FILE $PROM_FILE
chown prometheus:prometheus $PROM_FILE
 
echo "created BorgBackup statistic for {{ borgbackup_repos|length }} repos: $PROM_FILE"

