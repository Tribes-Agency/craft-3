#!/usr/bin/env bash

systemctl restart nginx || true

sleep 5

nginx

nginx -g 'daemon off;'
