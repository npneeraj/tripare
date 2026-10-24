#!/bin/bash
set -e

BACKUP_DIR="./backups"
LATEST_BACKUP=$(ls -t ${BACKUP_DIR}/db_backup_*.sql | head -n1)

if [ -z "$LATEST_BACKUP" ]; then
    echo "No backup file found in ${BACKUP_DIR}."
    exit 1
fi

echo "Restoring database from ${LATEST_BACKUP}..."
cat "${LATEST_BACKUP}" | docker exec -i local_postgres psql -U user -d hotel_db

echo "Restore completed successfully !"