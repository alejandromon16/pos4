FROM php:7.3-cli

# Instalar dependencias
RUN apt-get update -y && apt-get install -y libmcrypt-dev libpng-dev zip

# Instalar extensión GD para PHP
RUN docker-php-ext-install gd

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Establecer directorio de trabajo y copiar archivos de la aplicación
WORKDIR /app
COPY . /app

# Install dependencies using Composer, ignoring ext-zip requirement
RUN composer install --ignore-platform-req=ext-zip

# Exponer puerto 8000 y establecer comando predeterminado
EXPOSE 8000
CMD php artisan serve --host=0.0.0.0 --port=8000

