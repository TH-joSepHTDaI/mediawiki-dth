#!/bin/bash
set -e

echo "Running smoke test for MediaWiki..."

# Check container status
echo "Checking containers..."
docker ps | grep -q "wiki-app" && echo "✅ MediaWiki container running" || { echo "😬 wiki-app not running"; exit 1; }
docker ps | grep -q "wiki-db" && echo "✅ PostgreSQL container running" || { echo "😬 wiki-db not running"; exit 1; }

# Check Web Response (HTTP 200)
echo "Checking web response..."
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080)
if [ "$HTTP_CODE" -eq 200 ]; then
  echo "✅ MediaWiki homepage reachable"
else
  echo "😬 MediaWiki not responding properly (HTTP $HTTP_CODE)"
  exit 1
fi

# Check database health status
echo "Checking PostgreSQL health..."
PG_HEALTH=$(docker inspect --format='{{.State.Health.Status}}' wiki-db 2>/dev/null || echo "unknown")
echo "Postgres health: $PG_HEALTH"

echo "Smoke test passed!"
