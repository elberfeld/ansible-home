#!/bin/bash

export BORG_PASSPHRASE="{{repo_passphrase}}"
export BORG_RSH="ssh -i /srv/borgbackup/repo_sshkey"

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

BACKUPS=$(borg list --remote-path borg1 {{repo_url}})
BACKUPS_LIST=$(echo "$BACKUPS" | awk '{print $1}')
COUNTER=0

for BACKUP in $BACKUPS_LIST; do

  COUNTER=$((COUNTER+1))

done

BORG_INFO=$(borg info --remote-path borg1 {{repo_url}}::$BACKUP)

# create temp file 
TMP_FILE=$(mktemp)

echo "borgbackup_count $COUNTER" > $TMP_FILE
echo "borgbackup_files $(echo "$BORG_INFO" | grep "Number of files" | awk '{print $4}')" >> $TMP_FILE
echo "borgbackup_chunks_unique $(echo "$BORG_INFO" | grep "Chunk index" | awk '{print $3}')" >> $TMP_FILE
echo "borgbackup_chunks_total $(echo "$BORG_INFO" | grep "Chunk index" | awk '{print $4}')" >> $TMP_FILE

# byte size calculation 
LAST_SIZE=$(calc_bytes $(echo "$BORG_INFO" |grep "This archive" |awk '{print $3}') $(echo "$BORG_INFO" |grep "This archive" |awk '{print $4}'))
LAST_SIZE_COMPRESSED=$(calc_bytes $(echo "$BORG_INFO" |grep "This archive" |awk '{print $5}') $(echo "$BORG_INFO" |grep "This archive" |awk '{print $6}'))
LAST_SIZE_DEDUP=$(calc_bytes $(echo "$BORG_INFO" |grep "This archive" |awk '{print $7}') $(echo "$BORG_INFO" |grep "This archive" |awk '{print $8}'))
TOTAL_SIZE=$(calc_bytes $(echo "$BORG_INFO" |grep "All archives" |awk '{print $3}') $(echo "$BORG_INFO" |grep "All archives" |awk '{print $4}'))
TOTAL_SIZE_COMPRESSED=$(calc_bytes $(echo "$BORG_INFO" |grep "All archives" |awk '{print $5}') $(echo "$BORG_INFO" |grep "All archives" |awk '{print $6}'))
TOTAL_SIZE_DEDUP=$(calc_bytes $(echo "$BORG_INFO" |grep "All archives" |awk '{print $7}') $(echo "$BORG_INFO" |grep "All archives" |awk '{print $8}'))

echo "borgbackup_last_size $LAST_SIZE" >> $TMP_FILE
echo "borgbackup_last_size_compressed $LAST_SIZE_COMPRESSED" >> $TMP_FILE
echo "borgbackup_last_size_dedup $LAST_SIZE_DEDUP" >> $TMP_FILE
echo "borgbackup_total_size $TOTAL_SIZE" >> $TMP_FILE
echo "borgbackup_total_size_compressed $TOTAL_SIZE_COMPRESSED" >> $TMP_FILE
echo "borgbackup_total_size_dedup $TOTAL_SIZE_DEDUP" >> $TMP_FILE

# move temp file to output file 
mv $TMP_FILE $PROM_FILE
chown prometheus:prometheus $PROM_FILE
 
echo "created BorgBackup statistic for $COUNTER backups in $PROM_FILE"
