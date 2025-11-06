#!/bin/bash
echo "Checking container health..."
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# Test HTTPS endpoint via Nginx reverse proxy (ignore self-signed cert)
status_code=$(curl -k -s -o /dev/null -w "%{http_code}" https://media-wiki.example.com)
if [[ "$status_code" =~ ^(200|301|302)$ ]]; then
  echo "✅ MediaWiki is reachable through Nginx (HTTPS $status_code)"
else
  echo "😬 MediaWiki not responding via Nginx (HTTPS $status_code)"
  echo "   Try: docker logs wiki-proxy  (to inspect Nginx)"
fi

# Check PostgreSQL health container flag
db_health=$(docker inspect -f '{{.State.Health.Status}}' wiki-db 2>/dev/null)
if [[ "$db_health" == "healthy" ]]; then
  echo "🟢 PostgreSQL (wiki-db) is healthy"
else
  echo "🔴 PostgreSQL (wiki-db) not healthy or no healthcheck configured"
fi
