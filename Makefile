.PHONY: init up down logs restart clean status health

init:
	@echo "Preparing environment folders..."
	mkdir -p db-data mediawiki-data logs/mediawiki logs/postgres configs
	@echo "Environment ready."

up:
	docker-compose up -d --build

down:
	docker-compose down

logs:
	docker-compose logs -f

logs-app:
	docker-compose logs -f mediawiki

logs-db:
	docker-compose logs -f database

restart:
	docker-compose down && docker-compose up -d

clean:
	docker-compose down -v
	rm -rf db-data mediawiki-data logs/*

status:
	docker ps

check:
	bash scripts/healthcheck.sh

test:
	bash scripts/smoke_test.sh
