.PHONY: up down build install shell artisan test migrate fresh logs

up:
	docker compose up -d

down:
	docker compose down

build:
	docker compose up -d --build

install:
	docker compose exec app composer create-project laravel/laravel . --prefer-dist
	docker compose exec app php artisan key:generate
	docker compose exec app php artisan migrate

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

