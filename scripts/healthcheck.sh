#!/bin/bash
echo "🔍 Checking container health..."
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
curl -s -o /dev/null -w "%{http_code}" http://localhost:8080 | grep -q 200 && \
  echo "✅ MediaWiki is reachable" || echo "❌ MediaWiki not responding"
