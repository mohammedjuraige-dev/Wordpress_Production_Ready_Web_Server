#!/bin/bash
set -e

# Load environment variables
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

# Run the modules
bash 01_system_setup.sh
bash 02_nginx_setup.sh
bash 03_mysql_setup.sh
bash 04_wordpress_ops.sh
bash 05_ssl_setup.sh

echo "Deployment complete for $DOMAIN_OR_IP"
