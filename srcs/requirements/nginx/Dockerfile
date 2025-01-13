FROM    debian:bullseye

RUN apt update && apt upgrade -y \
    && apt install nginx openssl -y  \
    && mkdir -p /etc/nginx/ssl \
    && openssl req -x509 -nodes \
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=FR/ST=Nouvelle-Aquitaine/L=Angouleme/O=42/OU=42/CN=qdeviann.42.fr/UID=qdeviann" \ 
    && apt clean

RUN mkdir -p /var/run/nginx /var/www/html

COPY /conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]