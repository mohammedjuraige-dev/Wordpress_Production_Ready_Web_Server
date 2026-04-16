#!/bin/bash

set -e

# Load variables by looking one directory up (since the script is in /scripts)
if [ -f "../.env" ]; then
    export $(grep -v '^#' ../.env | xargs)
elif [ -f "./.env" ]; then
    export $(grep -v '^#' .env | xargs)
fi

echo "Requesting SSL Certificate..."

sudo apt install certbot python3-certbot-nginx -y
sudo certbot --nginx -d $DOMAIN_OR_IP --non-interactive --agree-tos -m $SSL_EMAIL

echo "Auto-renewal is managed by systemd certbot.timer"
echo "SSL Setup Complete"
