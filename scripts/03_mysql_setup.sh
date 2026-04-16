#!/bin/bash

set -e

# Load variables by looking one directory up (since the script is in /scripts)
if [ -f "../.env" ]; then
    export $(grep -v '^#' ../.env | xargs)
elif [ -f "./.env" ]; then
    export $(grep -v '^#' .env | xargs)
fi

echo "Configuring MySQL Database..."
sudo mysql -e "CREATE DATABASE IF NOT EXISTS $DB_NAME DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
sudo mysql -e "CREATE USER IF NOT EXISTS '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';"
sudo mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

echo "Database $DB_NAME created for user $DB_USER."


