#!/bin/bash

FECHA=$(date +%Y-%m-%d_%H-%M)
BACKUP_DIR=/home/quinelaUser/backups
CONTAINER=quinela-postgres-1

docker exec -t $CONTAINER pg_dump -U postgres -d quinela | gzip > $BACKUP_DIR/quinela_$FECHA.sql.gz

docker exec -t $CONTAINER pg_dump -U postgres -d userapp | gzip > $BACKUP_DIR/userapp_$FECHA.sql.gz

rclone copy $BACKUP_DIR/quinela_$FECHA.sql.gz gdrive:quinela-backups
rclone copy $BACKUP_DIR/userapp_$FECHA.sql.gz gdrive:quinela-backups

find $BACKUP_DIR -type f -name "*.sql.gz" -mtime +7 -delete

rclone delete gdrive:quinela-backups --min-age 30d
