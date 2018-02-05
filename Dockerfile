# Inspired mostly by laradock's php image

# We are using laradock's php-fpm as the base image
FROM laradock/php-fpm:2.0-71

LABEL maintainer="fahmadnaufal@gmail.com"

# Since laradock's php-fpm already satisfied most of the dependencies,
# now we only install some of the additional dependencies required by Rentuff
RUN apt-get update -y && \
    apt-get install -y postgresql-client \
            libmagickwand-dev imagemagick && \
    pecl install imagick mongodb && \
    docker-php-ext-enable imagick mongodb && \
    docker-php-ext-install tokenizer exif zip pgsql

ADD ./php.ini /usr/local/etc/php
ADD ./laravel.ini /usr/local/etc/php/conf.d
ADD ./xlaravel.pool.conf /usr/local/etc/php-fpm.d/

# Create new user
RUN usermod -u 1000 www-data

WORKDIR /var/www

CMD [ "php-fpm" ]

EXPOSE 9000