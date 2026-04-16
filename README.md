
```markdown
# 🚀 WordPress Production Server Deployment

This repository contains a modular shell script framework for deploying a hardened, production-ready WordPress stack on Ubuntu. It automates the installation of the **LEMP stack** (Linux, Nginx, MySQL, PHP 8.1) with a focus on performance, security, and automated SSL provisioning.

---

## 🏛 System Architecture

The deployment is split into specialized modules for easier maintenance and troubleshooting:

* **System Foundation**: Automates OS updates and strict firewall (UFW) configuration.
* **Web Server**: Nginx optimized for WordPress with rate-limiting and security headers.
* **Database**: Automated MySQL 8.0 user and database creation using environment variables.
* **PHP Stack**: PHP 8.1-FPM with essential extensions (MySQL, Curl, GD, Zip, etc.).
* **SSL/TLS**: Automatic certificate issuance and renewal via Certbot and Let's Encrypt.

---

## 🛡 Security Hardening

* **DDoS Mitigation**: Nginx rate-limiting (10r/s) with asset bursts to prevent service exhaustion.
* **PHP Security**: Hides PHP version headers and denies PHP execution in sensitive directories (uploads/files).
* **Access Control**: Global blocking of hidden files (e.g., `.git`, `.env`) and direct access to `wp-config.php`.
* **Application Protection**: Disables the built-in WordPress file editor to prevent browser-based code injection.
* **Filesystem Security**: `wp-config.php` is locked down to `600` permissions, restricted only to the `www-data` owner.

---

## 📋 Prerequisites

* A clean **Ubuntu** instance.
* A domain name pointing to your server's IP.
* A populated `.env` file in the root directory.

---

## 🚀 Deployment Guide

### 1. Configure the Environment
Create a `.env` file in the root directory:

```bash
DOMAIN_OR_IP="your-domain.com"
WEB_ROOT="/var/www/html/wordpress"
SSL_EMAIL="admin@your-domain.com"
DB_NAME="wordpress_db"
DB_USER="wp_admin"
DB_PASS="YourSecurePassword"
```

### 2. Run the Deployment
Execute the master script to trigger the full stack installation:

```bash
cd scripts
chmod +x *.sh
./deploy_all.sh
```

---

## ⚙️ Project Structure

* **scripts/**: Contains the modular shell scripts (`01_system_setup.sh` through `05_ssl_setup.sh`).
* **configs/**: Contains the Nginx `wordpress.conf` template.
* **.env**: Centralized configuration for all scripts (User-created).
```
