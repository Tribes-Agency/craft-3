FROM php:8.0-fpm

RUN apt update -y ; apt install -y git \
    curl \
    net-tools \
    zip \
    unzip \
    nginx \
    libzip-dev \
    libxml2-dev \
    zlib1g-dev libpng-dev \
    rsync \
    vim \
    sendmail

#install composer
RUN curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
RUN HASH=`curl -sS https://composer.github.io/installer.sig`
RUN php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

COPY composer.json composer.lock /var/www/html/

COPY . /var/www/html/

#execution script
RUN chmod +x shell.sh

CMD ["./shell.sh"]