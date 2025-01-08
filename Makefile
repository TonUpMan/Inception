COMP_FILE = srcs/docker-compose.yml
COMP = docker-compose
DIRS = /home/qdeviann/data/DB /home/qdeviann/data/WordPress /home/qdeviann/data/redisData

all: up

up:
	@echo "Checking and creating directories if necessary..."
	@for dir in $(DIRS); do \
		if [ ! -d $$dir ]; then \
			echo "Creating directory $$dir"; \
			mkdir -p $$dir; \
		else \
			echo "Directory $$dir already exists"; \
		fi \
	done
	@$(COMP) -f $(COMP_FILE) up --build -d

stop:
	@docker stop ${shell docker ps -qa} 

ps:
	@docker ps

ls:
	@docker image ls

vls:
	@docker volume ls

clean: stop
	@-docker rm ${shell docker ps -qa}

fclean: clean
	@-docker rmi -f ${shell docker images -qa}
	@-docker volume rm ${shell docker volume ls -q}

re: fclean up

prune:
	@docker system prune -f

mariadb:
	@docker exec -it $$(docker ps -q -f name=mariadb) bash

wordpress:
	@docker exec -it $$(docker ps -q -f name=wordpress) bash

nginx:
	@docker exec -it $$(docker ps -q -f name=nginx) bash

redis:
	@docker exec -it $$(docker ps -q -f name=redis) bash

ftp:	
	@docker exec -it $$(docker ps -q -f name=FTP) bash

PHONY.: up stop re clean fclean ps ls vls prune mariadb wordpress nginx redis ftp 