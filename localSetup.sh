#!/bin/bash
set -e

# Fetch the password directly from AWS SSM
echo "Fetching database password from AWS SSM..."
export DB_PASSWORD=$(aws ssm get-parameter \
    --name "/postgres/db_password" \
    --with-decryption \
    --query "Parameter.Value" \
    --output text)

# Set non-sensitive variables
export DB_USER="user"
export DB_NAME="hotel_db"

echo "Starting local database..."
docker compose up -d