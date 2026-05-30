FROM php:8.4-fpm AS base

ARG UID=1000
ARG GID=1000

RUN apt-get update && apt-get install -y --no-install-recommends \
        git curl zip unzip libpng-dev liboning-dev \
    && docker-php-ext-install pdo pdo_mysql mbstring zip bcmath opcache \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

RUN groupadd -g ${GID} appgroup \
    && useradd -u ${UID} -g appgroup -m appuser

WORKDIR /var/www

FROM base AS dev 
COPY docker/php/php.ini /usr/local/etc/php/conf.d/custom.ini

USER appuser

FROM base AS prod
COPY --chown=appuser:appgroup . /var/www
COPY docker/php/php.ini /usr/local/etc/php/conf.d/custom.ini
USER appuser
RUN composer install --no-dev --optimize-autoloader
