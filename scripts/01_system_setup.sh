#!/bin/bash

set -e

# Load variables by looking one directory up (since the script is in /scripts)
if [ -f "../.env" ]; then
    export $(grep -v '^#' ../.env | xargs)
elif [ -f "./.env" ]; then
    export $(grep -v '^#' .env | xargs)
fi

echo "Updating the System"
sudo apt update && sudo apt upgrade -y

echo "Firewall Installation"
sudo apt install ufw -y

echo "Firewall Traffic Setting"
sudo ufw default deny incoming
sudo ufw default allow outgoing

echo "SSH, HTTP, HTTPS allowing"
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https

echo "Firewall startup"
# --force skips the interactive y/n prompt so the script doesn't hang
sudo ufw --force enable


echo "Nginx Installation"
sudo apt install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx

echo "Installing PHP 8.1 FPM & Extensions"
# Pin to 8.1 explicitly so the socket path and service name below stay consistent.
# If your distro doesn't carry 8.1, add the ondrej/php PPA first.
sudo apt install php8.1-fpm php8.1-mysql php8.1-curl php8.1-gd php8.1-mbstring php8.1-xml php8.1-xmlrpc php8.1-soap php8.1-intl php8.1-zip -y

sudo systemctl enable php8.1-fpm
sudo systemctl start php8.1-fpm

echo "Installing MySQL..."
sudo apt install mysql-server -y


echo "Requesting SSL Certificate..."
sudo apt install certbot python3-certbot-nginx -y


