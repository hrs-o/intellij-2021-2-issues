FROM php:8.0-fpm-bullseye


ENV COMPOSER_ALLOW_SUPERUSER=1
ENV COMPOSER_NO_INTERACTION=1
ENV COMPOSER_MEMORY_LIMIT=-1

ENV PATH="/root/.composer/vendor/bin:$PATH"
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN apt update \
    && apt install -y git libzip-dev \
    && docker-php-ext-install -j$(nproc) zip pdo_mysql mysqli

RUN mkdir -p /app/src
WORKDIR /app/src
