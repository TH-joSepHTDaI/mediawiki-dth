# Use the official MediaWiki image
FROM mediawiki:1.44

# The base MediaWiki image comes with PHP but without PostgreSQL drivers.
# We install 'libpq-dev' (PostgreSQL client libraries) and enable
# PHP extensions 'pgsql' and 'pdo_pgsql' so MediaWiki can talk to PostgreSQL.
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends libpq-dev; \
    docker-php-ext-install pgsql pdo_pgsql; \
    rm -rf /var/lib/apt/lists/*

# --------------------------------------------------------
# Install Git and the CategoryTree extension (REL1_44)
# --------------------------------------------------------
# 1. Install git temporarily to check or fetch extensions.
# 2. Only clone if it does not already exist.
# 3. Optionally, clean up unnecessary packages to keep the image lightweight.
RUN set -eux; \
    apt-get update && apt-get install -y --no-install-recommends git; \
    cd /var/www/html/extensions; \
    if [ ! -d "CategoryTree" ]; then \
        git clone -b REL1_44 https://gerrit.wikimedia.org/r/mediawiki/extensions/CategoryTree.git; \
    else \
        echo "CategoryTree already exists, skipping clone."; \
    fi; \
    apt-get purge -y git && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

# Keep the default startup command (Apache running in the foreground)
CMD ["apache2-foreground"]
