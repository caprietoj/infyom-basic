# Usar Alpine Linux como imagen base
FROM alpine:latest

# Instalar Apache, PHP y las extensiones necesarias, y Composer
RUN apk add --no-cache apache2 php7 php7-apache2 php7-pdo php7-pdo_mysql php7-json php7-openssl php7-curl \
    php7-zlib php7-xml php7-phar php7-intl php7-dom php7-xmlreader php7-ctype php7-session php7-mbstring \
    && php7 -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php7 -r "if (hash_file('SHA384', 'composer-setup.php') === 'a5c698ffe4b8e2aabd3f7023a84c8e8f4b4fe4d5e5bf37eeac6ed2316e2b33b7d4b5b913c77c9a6b0800cfe09a4927a1') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php7 composer-setup.php \
    && php7 -r "unlink('composer-setup.php');"

# Configurar Apache
COPY apache.conf /etc/apache2/httpd.conf

# Exponer el puerto 8000
EXPOSE 8000

# Copiar los archivos del directorio actual a /var/www
COPY . /var/www

# Establecer el directorio de trabajo
WORKDIR /var/www

# Instalar las dependencias de PHP usando Composer
RUN php7 /usr/local/bin/composer install

# Ejecutar los comandos de Artisan
RUN php7 artisan migrate
RUN php7 artisan make:generate
RUN php7 artisan migrate
# Iniciar el servidor web de Apache en segundo plano
CMD ["apachectl", "-D", "FOREGROUND"]


# Iniciar Apache
CMD ["httpd", "-D", "FOREGROUND"]
