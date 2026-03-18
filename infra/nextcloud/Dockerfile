FROM nextcloud:latest

# PHP-FPM конфигурация
COPY php-fpm-custom.conf /usr/local/etc/php-fpm.d/www.conf

# Включаем встроенное расширение Redis
RUN docker-php-ext-enable redis

# Настройка прав для cron
RUN chown -R www-data:www-data /var/www/html
