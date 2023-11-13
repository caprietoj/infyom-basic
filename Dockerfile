# Utilizamos Alpine Linux como imagen base
FROM alpine:latest

# Instalamos Apache2 y PHP 8 junto con los módulos necesarios
RUN apk add --no-cache apache2 php8 php8-apache2 php8-pdo php8-pdo_mysql php8-json php8-openssl php8-curl \
    php8-zlib php8-xml php8-phar php8-intl php8-dom php8-xmlreader php8-ctype php8-session php8-mbstring \
    apache2-utils

# Instalamos Composer para la gestión de dependencias de PHP
RUN php8 -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php8 composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php8 -r "unlink('composer-setup.php');"

# Configuramos Apache
RUN sed -i 's/#LoadModule rewrite_module/LoadModule rewrite_module/' /etc/apache2/httpd.conf
RUN echo "ServerName localhost" >> /etc/apache2/httpd.conf

# Exponemos el puerto 8000
EXPOSE 8000

# Configuramos el directorio de trabajo
WORKDIR /var/www/localhost/htdocs

# Copiamos los archivos de nuestro proyecto al contenedor
COPY . /var/www/localhost/htdocs

# Asignamos permisos al directorio de Apache
RUN chown -R apache:apache /var/www

# Ejecutamos comandos de Artisan
RUN php8 artisan migrate
RUN php8 artisan make:generate
RUN php8 artisan serve --host=0.0.0.0 --port=8000

# Especificamos el comando por defecto para iniciar Apache
CMD ["httpd", "-D", "FOREGROUND"]
