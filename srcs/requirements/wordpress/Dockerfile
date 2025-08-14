FROM debian:bookworm

USER root

# Install PHP 8.2 and required packages
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    sendmail \
    mariadb-client \
    php \
    php-fpm \
    php-mysql \
    php-mysqli \
    && mkdir -p /run/php \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# Install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Copy PHP-FPM config for PHP 8.2
COPY ./requirements/wordpress/conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

# Copy entrypoint script
COPY ./requirements/wordpress/tools/docker_entry.sh /usr/local/bin/

ENTRYPOINT ["docker_entry.sh"]
