# MediaWiki Project with PostgreSQL and Nginx (v2)

This repository provides a reproducible DevOps environment for running [MediaWiki](https://www.mediawiki.org/wiki/MediaWiki) with a PostgreSQL database and an Nginx reverse proxy.

The goal of this version (v2) is to demonstrate a more production-like setup that includes:
- **Reproducible environment setup** via Docker Compose  
- **Secure HTTPS access** through Nginx reverse proxy with SSL  
- **Environment automation** using Makefile commands  
- **Observability** via container logs, health checks, and smoke tests

---

## Project Structure

```
.
├── Makefile # Automation entry point (up, down, logs, test...)
├── .env # Environment variables
├── configs
├── db-data # Persistent database volume
├── docker-compose.yml # Defines services: Nginx + MediaWiki + PostgreSQL
├── nginx/
│   ├── default.conf
│   └── ssl/
│       ├── server.crt   # self-signed certificate
│       └── server.key
├── logs
│   ├── mediawiki # Apache/MediaWiki logs
│   ├── nginx # Nginx logs
│   └── postgres # PostgreSQL logs
├── mediawiki-data # Persistent MediaWiki volume
├── mediawiki
│   └── Dockerfile # Extended MediaWiki image with custom Dockerfile
├── postgres
│   ├── configs # Apache/MediaWiki logs
│   │    └── postgresql.conf # Custom PostgreSQL configuration
│   └── Dockerfile # Extended Postgres image with custom Dockerfile
├── LocalSettings.php # Wiki project settings
└── scripts
    ├── healthcheck.sh # Container health verification script
    └── smoke_test.sh # Automated smoke test for web + DB availability
```

---

## Prerequisites

Make sure the following are installed on your machine:

- Docker Desktop
- Make
- Git

---

## Quick Start (Bash)

### 1. Initialize local environment
```bash
make init
```
This creates required directories (db-data, logs, configs, mediawiki-data) for persistent data and logs.

### 2. Start all services
```bash
make up
```
Access the MediaWiki homepage at: 
[https://media-wiki.example.com](https://media-wiki.example.com)

### 3. View logs
```bash
make logs
make logs-app
make logs-db
```
All logs are also persisted locally under logs/.

### 4. Run automated smoke test
```bash
make test
```
This executes scripts/smoke_test.sh, which:
    - Verifies both containers are running
    - Checks that MediaWiki returns HTTP 200
    - Confirms PostgreSQL is healthy

### 5. Stop and clean up
```bash
make down
make clean
```

---

## 🧩 Credits

- **MediaWiki Docker Image:** [https://hub.docker.com/_/mediawiki](https://hub.docker.com/_/mediawiki)  
- **PostgreSQL Docker Image:** [https://hub.docker.com/_/postgres](https://hub.docker.com/_/postgres)  
- **Author:** Tianhua Dai  

---

## 📅 Version History

| Version | Description | Key Changes | 
|---------|-------------|---------------|
| **v0** | Local Basic Version | - Basic Docker Compose setup with MediaWiki and PostgreSQL services.<br> - MediaWiki successfully running on localhost (http://localhost:8080). |
| **v1** | PostgreSQL Extension & Logging | - Extended MediaWiki image with custom Dockerfile to include PostgreSQL PHP extensions.<br> - Enabled PostgreSQL file logging via logging_collector and mounted logs to local path. |
| **v1.1** | CategoryTree Extension Integration | - Added automatic installation of the MediaWiki CategoryTree (REL1_44) extension through the Docker build process.<br> - Check installed extensions on (http://localhost:8080/index.php/Special:Version) |
| **v2** | Nginx Reverse Proxy + SSL Integration | - Added an Nginx service to act as a reverse proxy for MediaWiki, handling all HTTP/HTTPS traffic.<br> - Configured self-signed SSL certificates for local HTTPS access at `https://media-wiki.example.com`.<br> - Modified `LocalSettings.php` to recognize HTTPS behind the proxy and fix redirect issues. |
