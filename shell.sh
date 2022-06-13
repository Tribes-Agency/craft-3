#!/usr/bin/env bash

php-fpm -D
service nginx start
nginx -g 'daemon off;'
