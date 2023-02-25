#!/bin/bash
## Docker and some tools

# sudo apt-get update
# curl -fsSL https://get.docker.com -o get-docker.sh
# sudo sh get-docker.sh
# sudo service docker start
# sudo apt install docker-compose git httpie jq   -y

# curl -s "https://laravel.build/example-app" | bash


# cd example-app

# cat << EOF > docker-compose-statamic.yml

# # For more information: https://laravel.com/docs/sail
# version: '3'
# services:
#     laravel.test:
#         build:
#             context: ./vendor/laravel/sail/runtimes/8.1
#             dockerfile: Dockerfile
#             args:
#                 WWWGROUP: '${WWWGROUP}'
#         image: sail-8.1/app
#         extra_hosts:
#             - 'host.docker.internal:host-gateway'
#         ports:
#             - '${APP_PORT:-80}:80'
#         environment:
#             WWWUSER: '${WWWUSER}' 
#             LARAVEL_SAIL: 1
#             XDEBUG_MODE: '${SAIL_XDEBUG_MODE:-off}'
#             XDEBUG_CONFIG: '${SAIL_XDEBUG_CONFIG:-client_host=host.docker.internal}'
#         volumes:
#             - '.:/var/www/html'
#         networks:
#             - sail
# networks:
#     sail:
#         driver: bridge
# EOF
# docker-compose -f docker-compose-statamic.yml up -d

# # git clone https://github.com/TrafeX/docker-wordpress.git
# # cd docker-wordpress




# ./vendor/bin/sail up

# cat << EOF > .ssh/authorized_keys

# EOF
