FROM php:7.3-fpm

RUN apt-get update -y \
    && apt-get install -y nginx

RUN docker-php-ext-install pdo_mysql \
    && docker-php-ext-install opcache \
    && apt-get install libicu-dev -y \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && apt-get remove libicu-dev icu-devtools -y

RUN { \
        echo 'opcache.memory_consumption=128'; \
        echo 'opcache.interned_strings_buffer=8'; \
        echo 'opcache.max_accelerated_files=4000'; \
        echo 'opcache.revalidate_freq=2'; \
        echo 'opcache.fast_shutdown=1'; \
        echo 'opcache.enable_cli=1'; \
    } > /usr/local/etc/php/conf.d/php-opcache-cfg.ini


COPY nginx-site.conf /etc/nginx/conf.d/default.conf
COPY entrypoint.sh /etc/entrypoint.sh

# if you are under Windows run this command
#RUN chmod +x /etc/entrypoint.sh

# Copy all needed yii2 folders on /var/www
#COPY assets /var/www/assets
#COPY commands /var/www/commands
#COPY components /var/www/components
#COPY controllers /var/www/controllers
#COPY messages /var/www/messages
#COPY models /var/www/models
#COPY themes /var/www/themes
#COPY widgets /var/www/widgets

# Also copy these folders
#COPY vendor /var/www/vendor
#COPY runtime /var/www/runtime

# This is the trick for yii2
COPY web /var/www/html

RUN chown -R www-data:www-data /var/www


ENTRYPOINT ["/etc/entrypoint.sh"]
