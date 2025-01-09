#!/bin/bash

: "${SQL_HOST:?Variable SQL_HOST non définie}"
: "${SQL_USER:?Variable SQL_USER non définie}"
: "${SQL_PASSWORD:?Variable SQL_PASSWORD non définie}"

chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

apache2ctl -D FOREGROUND
