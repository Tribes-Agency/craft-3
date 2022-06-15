FROM php:8.1-fpm

WORKDIR /workspaces

RUN apt update -y ; apt install -y git \
    net-tools \
    nodejs \
    npm \
    gulp \
    gpg \
    curl \
    zip \
    unzip \
    zlib1g-dev libpng-dev \
    libzip-dev \
    libxml2-dev \
    nginx \
    libzip-dev \
    libxml2-dev \
    zlib1g-dev libpng-dev \
    vim

#install composer
RUN curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
RUN HASH=`curl -sS https://composer.github.io/installer.sig`
RUN php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

RUN docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable pdo_mysql
RUN docker-php-ext-install zip
RUN docker-php-ext-install gd
RUN docker-php-ext-install xml
RUN docker-php-ext-install soap
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install intl


#Copy the source code
COPY composer.json composer.lock ./
COPY . .
COPY .env.example .env

#setup Craft CMS using its official command.
#RUN composer create-project madebyshape/craft-cms

COPY ./.deploy/api.conf /etc/nginx/sites-enabled/default

#execution script
RUN chmod +x ./shell.sh

CMD ["./shell.sh"]