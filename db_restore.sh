#!/bin/bash

# Restore script for a PostgreSQL database in a Docker container

# Check if database name and backup file path were provided as arguments
DB_NAME=${1:-}
BACKUP_FILE=${2:-}

# Prompt for database name if not provided
if [ -z "$DB_NAME" ]; then
    read -p "Enter the name of the database to restore: " DB_NAME
fi

# Prompt for backup file path if not provided
if [ -z "$BACKUP_FILE" ]; then
    read -p "Enter the path to the backup file (e.g., pgdump-YYYY-MM-DD_HH-MM-SS.dump): " BACKUP_FILE
fi

# Check if the backup file exists
if [ ! -f "$BACKUP_FILE" ]; then
    echo "Backup file not found: $BACKUP_FILE"
    exit 1
fi

# Terminate active connections to the specified database
echo "Terminating active connections to '$DB_NAME'..."
docker compose exec -T db psql -U postgres -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = '$DB_NAME' AND pid != pg_backend_pid() AND leader_pid IS NULL;"

# Drop the existing database
echo "Dropping existing database '$DB_NAME'..."
docker compose exec -T db psql -U postgres -c "DROP DATABASE IF EXISTS \"$DB_NAME\";"

# Create a new database with UTF8 encoding
echo "Creating new database '$DB_NAME' with UTF8 encoding..."
docker compose exec -T db psql -U postgres -c "CREATE DATABASE \"$DB_NAME\" ENCODING 'UTF8';"

# Restore the database from the backup file
echo "Restoring database '$DB_NAME' from backup file '$BACKUP_FILE'..."
docker compose -f docker-compose.prod.yml exec -T db bash -c "pg_restore -U postgres -v -d \"$DB_NAME\"" < "$BACKUP_FILE"

# Confirm restoration completion
if [ $? -eq 0 ]; then
    echo "Database restored successfully from $BACKUP_FILE."
else
    echo "Database restoration failed."
fi
