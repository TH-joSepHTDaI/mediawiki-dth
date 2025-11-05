# Use the official MediaWiki image
FROM mediawiki:1.44

# Install PostgreSQL support for PHP (pgsql and pdo_pgsql)
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends libpq-dev; \
    docker-php-ext-install pgsql pdo_pgsql; \
    rm -rf /var/lib/apt/lists/*

# Keep the default startup command (Apache running in the foreground)
CMD ["apache2-foreground"]
