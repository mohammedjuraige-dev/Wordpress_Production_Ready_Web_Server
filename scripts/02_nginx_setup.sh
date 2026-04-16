#!/bin/bash

set -e

# --- LOAD ENVIRONMENT VARIABLES ---
# Check for .env in parent or current directory
if [ -f "../.env" ]; then
    export $(grep -v '^#' ../.env | xargs)
elif [ -f "./.env" ]; then
    export $(grep -v '^#' .env | xargs)
fi



echo "Applying environment variables to Nginx config..."

sudo rm -rf /var/www/html/*

if [ -f /etc/nginx/sites-enabled/default ]; then
    sudo unlink /etc/nginx/sites-enabled/default
fi


envsubst '$DOMAIN_OR_IP $WEB_ROOT' < ../configs/nginx/wordpress.conf | sudo tee /etc/nginx/sites-available/wordpress > /dev/null

sudo ln -sf /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled

sudo nginx -t

sudo systemctl reload nginx
