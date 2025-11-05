#!/bin/bash
set -e

echo "Running smoke test for MediaWiki..."

# Check container status
echo "Checking containers..."
docker ps | grep -q "wiki-app" && echo "✅ MediaWiki container running" || { echo "😬 wiki-app not running"; exit 1; }
docker ps | grep -q "wiki-db" && echo "✅ PostgreSQL container running" || { echo "😬 wiki-db not running"; exit 1; }

# Check Web Response
echo "Checking web response..."
status_code=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080)
if [[ "$status_code" =~ ^(200|301|302)$ ]]; then
  echo "✅ MediaWiki is reachable (HTTP $status_code)"
else
  echo "😬 MediaWiki not responding (HTTP $status_code)"
fi

# Check database health status
echo "Checking PostgreSQL health..."
PG_HEALTH=$(docker inspect --format='{{.State.Health.Status}}' wiki-db 2>/dev/null || echo "unknown")
echo "Postgres health: $PG_HEALTH"

echo "Smoke test passed!"
