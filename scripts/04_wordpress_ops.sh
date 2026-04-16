#!/bin/bash

set -e

# Load variables by looking one directory up (since the script is in /scripts)
if [ -f "../.env" ]; then
    export $(grep -v '^#' ../.env | xargs)
elif [ -f "./.env" ]; then
    export $(grep -v '^#' .env | xargs)
fi



echo "Downloading and Extracting WordPress"
echo "------------------------------------------"
cd /tmp
curl -O https://wordpress.org/latest.tar.gz

tar xzvf latest.tar.gz

sudo mkdir -p $WEB_ROOT
sudo cp -a /tmp/wordpress/. $WEB_ROOT/

# Set correct ownership on the entire web root so WordPress can write files
sudo chown -R www-data:www-data $WEB_ROOT
sudo find $WEB_ROOT -type d -exec chmod 755 {} \;
sudo find $WEB_ROOT -type f -exec chmod 644 {} \;

# Cleanup temporary files (use absolute paths since we cd'd to /tmp earlier)
rm /tmp/latest.tar.gz
rm -rf /tmp/wordpress

echo "WordPress source files are now in $WEB_ROOT"

echo "Configuring WordPress Database Connection..."
sudo cp $WEB_ROOT/wp-config-sample.php $WEB_ROOT/wp-config.php

sudo sed -i "s/database_name_here/$DB_NAME/" $WEB_ROOT/wp-config.php
sudo sed -i "s/username_here/$DB_USER/" $WEB_ROOT/wp-config.php
sudo sed -i "s/password_here/$DB_PASS/" $WEB_ROOT/wp-config.php

sudo chown www-data:www-data $WEB_ROOT/wp-config.php



# Append DISALLOW_FILE_EDIT before locking down permissions
echo "define('DISALLOW_FILE_EDIT', true);" | sudo tee -a $WEB_ROOT/wp-config.php > /dev/null

# Lock down wp-config.php — only the owner (www-data) can read it
sudo chmod 600 $WEB_ROOT/wp-config.php


