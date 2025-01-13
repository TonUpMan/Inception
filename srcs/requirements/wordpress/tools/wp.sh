#!/bin/bash

until mysql -h ${SQL_HOST} -u root -p"${SQL_ROOT_PASSWORD}" -e "SHOW DATABASES;"; do
    echo "Waiting for MariaDB to be ready for WP..."
    sleep 4
done

if [ ! -f /var/www/html/wp-config.php ]; then

    wp config create \
        --dbname="${SQL_DATABASE}" \
        --dbuser="${SQL_USER}" \
        --dbpass="${SQL_PASSWORD}" \
        --dbhost="${SQL_HOST}" \
        --allow-root

    wp core install \
        --url="${WP_URL}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_A_USER}" \
        --admin_password="${WP_A_PASS}" \
        --admin_email="${WP_A_MAIL}" \
        --allow-root
fi

wp user create \
    "${WP_USER}" "${WP_MAIL}" \
    --role="subscriber" \
    --user_pass="${WP_PASSWORD}" \
    --allow-root

wp user list --allow-root

php-fpm7.4 -F
