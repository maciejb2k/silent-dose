#!/bin/bash

# Backup script for the "silent-dose_production" database

# Define the database name and timestamp format
DB_NAME="silent-dose_production"
TIMESTAMP=$(date +%F_%H-%M-%S)
DEFAULT_BACKUP_DIR="."  # Default location is the current directory

# Check if a backup directory was provided as an argument
BACKUP_DIR=${1:-$DEFAULT_BACKUP_DIR}
BACKUP_FILE="$BACKUP_DIR/pgdump-$TIMESTAMP.dump"

# Ensure the backup directory exists
mkdir -p "$BACKUP_DIR"

# Run pg_dump in the Docker container to create a backup
echo "Starting backup of database '$DB_NAME'..."
docker compose -f docker-compose.prod.yml exec -T db pg_dump -U postgres -Fc "$DB_NAME" > "$BACKUP_FILE"

# Confirm backup completion
if [ $? -eq 0 ]; then
    echo "Backup successful: $BACKUP_FILE"
else
    echo "Backup failed."
fi
