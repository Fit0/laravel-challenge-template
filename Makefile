.PHONY: up down build install shell artisan test migrate fresh logs

up:
	docker compose up -d

down:
	docker compose down

build:
	DOCKER_UID=$(shell id -u) DOCKER_GID=$(shell id -g) docker compose up -d --build

install:
	docker compose exec app composer install --prefer-dist --no-interaction
	docker compose exec app php artisan key:generate --ansi
	docker compose exec app php artisan migrate --force

shell:
	docker compose exec app bash

artisan:
	docker compose exec app php artisan $(cmd)

test:
	docker compose exec app ./vendor/bin/pest

migrate:
	docker compose exec app php artisan migrate

fresh:
	docker compose exec app php artisan migrate:fresh --seed

logs:
	docker compose logs -f app nginx
	