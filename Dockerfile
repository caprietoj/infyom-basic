FROM php:7.4-apache

WORKDIR /var/www/html

COPY . .

RUN apt-get update && \
    apt-get install -y libzip-dev zip && \
    docker-php-ext-install zip && \
    a2enmod rewrite && \
    service apache2 restart
