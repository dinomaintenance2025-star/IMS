FROM php:8.2-apache

# Install extensions and utilities required for mysqli/pdo
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       libpng-dev \
       libonig-dev \
       libxml2-dev \
       zip \
       unzip \
       git \
    && docker-php-ext-install mysqli pdo pdo_mysql \
    && a2enmod rewrite \
    && rm -rf /var/lib/apt/lists/*

# Copy project files into web root
COPY . /var/www/html/

# Ensure proper permissions
RUN chown -R www-data:www-data /var/www/html \
    && find /var/www/html -type f -exec chmod 644 {} \; \
    && find /var/www/html -type d -exec chmod 755 {} \;

EXPOSE 80

CMD ["apache2-foreground"]
