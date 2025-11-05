# MediaWiki DevOps Environment (v1)

This repository provides a local DevOps environment for running [MediaWiki](https://www.mediawiki.org/wiki/MediaWiki) with a PostgreSQL database.

The goal of this version (v1) is to demonstrate:
- Reproducible environment setup via Docker Compose  
- Automation through Makefile commands  
- Observability (logs, healthcheck, smoke tests)  

---

## Project Structure
.
├── Makefile # Automation entry point (up, down, logs, test...)
├── .env # Environment variables
├── configs
│   └── postgres
│       └── postgresql.conf # Custom PostgreSQL configuration (logging enabled)
├── db-data # Persistent database volume
├── docker-compose.yml # Defines services: MediaWiki + PostgreSQL
├── logs
│   ├── mediawiki # Apache/MediaWiki logs
│   └── postgres # PostgreSQL logs
├── mediawiki-data # Persistent MediaWiki volume
└── scripts
    ├── healthcheck.sh # Container health verification script
    └── smoke_test.sh # Automated smoke test for web + DB availability


---

## Prerequisites

Make sure the following are installed on your machine:

- Docker Desktop
- Make
- Git

---

## Quick Start (Bash)

### 1. Initialize local environment
make init
This creates required directories (db-data, logs, configs, mediawiki-data) for persistent data and logs.

### 2. Start all services
make up
Access the MediaWiki homepage at: http://localhost:8080

### 3. View logs
make logs
make logs-app
make logs-db
All logs are also persisted locally under logs/.

### 4. Run automated smoke test
make test
This executes scripts/smoke_test.sh, which:
    - Verifies both containers are running
    - Checks that MediaWiki returns HTTP 200
    - Confirms PostgreSQL is healthy

### 5. Stop and clean up
make down
make clean

---
