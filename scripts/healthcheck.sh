#!/bin/bash
echo "Checking container health..."
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
status_code=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080)
if [[ "$status_code" =~ ^(200|301|302)$ ]]; then
  echo "✅ MediaWiki is reachable (HTTP $status_code)"
else
  echo "😬 MediaWiki not responding (HTTP $status_code)"
fi
