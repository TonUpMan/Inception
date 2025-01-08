#!/bin/bash

mysqld_safe &
echo "Starting MariaDB..."

sleep 10

until mysqladmin ping --silent; do
    echo "Waiting for MariaDB to be ready..."
    sleep 1
done

if ! mysql -u root -p"${SQL_ROOT_PASSWORD}" -e "USE \`${SQL_DATABASE}\`;"; then
    echo "Database '${SQL_DATABASE}' does not exist. Creating..."
    mysql -u root -p"${SQL_ROOT_PASSWORD}" -e "CREATE DATABASE \`${SQL_DATABASE}\`;"
fi

if ! mysql -u root -p"${SQL_ROOT_PASSWORD}" -e "SELECT User FROM mysql.user WHERE User = '${SQL_USER}';" | grep -q "${SQL_USER}"; then
    echo "User '${SQL_USER}' does not exist. Creating..."
    mysql -u root -p"${SQL_ROOT_PASSWORD}" -e "CREATE USER \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
fi

mysql -u root -p"${SQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -u root -p"${SQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"

mysql -u root -p"${SQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown
exec mysqld_safe
