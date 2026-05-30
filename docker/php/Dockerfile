FROM php:8.4-fpm AS base

ARG UID=1000
ARG GID=1000

RUN apt-get update && apt-get install -y --no-install-recommends \
        git curl zip unzip \
        libpng-dev \
        libonig-dev \
        libxml2-dev \
        libzip-dev \
    && docker-php-ext-install pdo pdo_mysql mbstring zip bcmath opcache gd \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

RUN groupadd -g ${GID} appgroup \
    && useradd -u ${UID} -g appgroup -m appuser \
    && mkdir -p /var/www \
    && chown -R appuser:appgroup /var/www

WORKDIR /var/www

USER appuser

# ──────────────────────────────────────────────
FROM base AS dev

COPY docker/php/php.ini /usr/local/etc/php/conf.d/custom.ini
CMD ["php-fpm"]

# ──────────────────────────────────────────────
FROM base AS prod

COPY --chown=appuser:appgroup . /var/www
COPY docker/php/php.ini /usr/local/etc/php/conf.d/custom.ini
RUN composer install --no-dev --optimize-autoloader
CMD ["php-fpm"]
