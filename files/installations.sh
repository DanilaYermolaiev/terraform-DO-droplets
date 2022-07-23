#!/bin/bash
## Docker and some tools

sudo apt-get update
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo service docker start
sudo apt install docker-compose git httpie  jq -y
