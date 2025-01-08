FROM    debian:bullseye

RUN apt update && apt upgrade -y \
    && apt install mariadb-server -y \
	&& apt clean

RUN mkdir /var/tools

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/mariadb.sh /var/tools

RUN chmod 744 /var/tools/mariadb.sh

EXPOSE 3306

CMD ["./var/tools/mariadb.sh"]