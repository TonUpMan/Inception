FROM    debian:bullseye

RUN apt update && apt upgrade -y 
RUN apt install wget -y \
	curl \
	git \
	unzip \
	php7.4 \
	php-zip \
	php-fpm \
	php-redis \
	php-mysqli \
	mariadb-client \
	&& apt clean

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html
RUN curl -O https://wordpress.org/wordpress-6.7.zip \
	&& unzip wordpress-6.7.zip \
	&& rm wordpress-6.7.zip \
	&& mv wordpress/* . \
	&& rmdir wordpress

RUN	chown -R www-data:www-data /var/www/html
RUN mkdir -p /run/php && chown -R www-data:www-data /run/php

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY tools/wp.sh /usr/local/bin/wp.sh

RUN chmod +x /usr/local/bin/wp.sh

EXPOSE 9000

CMD ["/usr/local/bin/wp.sh"]