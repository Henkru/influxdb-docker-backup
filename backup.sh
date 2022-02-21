#!/bin/sh

# Make sure the backup directory exists
mkdir /backup 2> /dev/null

# Run pre-backup scripts
find /pre.d -type f -exec sh "{}" ";"

# Run default backup
[ -z ${DISABLE_DEFAULT_BACKUP+x} ] && influx backup /backup/influxdb

# Upload backup files
backup

# Run post-backup scripts
find /post.d -type f -exec sh "{}" ";"

# Delete the snapshot
[ -z ${DISABLE_DEFAULT_BACKUP+x} ] && rm -rf /backup/influxdb
