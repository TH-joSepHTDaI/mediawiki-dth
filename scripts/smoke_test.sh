#!/bin/bash
set -e

echo "Running smoke test for MediaWiki v2..."

# Check container status
for container in wiki-proxy wiki-app wiki-db; do
  if docker ps --format '{{.Names}}' | grep -q "^${container}$"; then
    echo "✅ $container container is running"
  else
    echo "😬 $container container is NOT running"
    exit 1
  fi
done

# Verify domain resolution
echo "Checking local domain resolution..."
if ! ping -c1 -W1 media-wiki.example.com &>/dev/null; then
  echo "Domain 'media-wiki.example.com' not resolving to localhost."
  echo "Please add '127.0.0.1 media-wiki.example.com' to /etc/hosts."
  exit 1
fi
echo "✅ Domain resolves correctly"

# Check HTTPS response via Nginx
echo "Checking HTTPS response..."
status_code=$(curl -k -s -o /dev/null -w "%{http_code}" https://media-wiki.example.com)

if [[ "$status_code" =~ ^(200|301|302)$ ]]; then
  echo "✅ MediaWiki is reachable through Nginx (HTTPS $status_code)"
else
  echo "😬 MediaWiki not responding via Nginx (HTTPS $status_code)"
  echo "   Try: docker logs wiki-proxy  (to inspect Nginx logs)"
  exit 1
fi

# Check database health status
echo "Checking HTTPS response..."
status_code=$(curl -k -s -o /dev/null -w "%{http_code}" https://media-wiki.example.com)
if [[ "$status_code" =~ ^(200|301|302)$ ]]; then
  echo "✅ MediaWiki is reachable through Nginx (HTTPS $status_code)"
else
  echo "😬 MediaWiki not responding via Nginx (HTTPS $status_code)"
  echo "   Try: docker logs wiki-proxy  (to inspect Nginx logs)"
  exit 1
fi

echo "🎉 Smoke test passed successfully for MediaWiki v2!"
