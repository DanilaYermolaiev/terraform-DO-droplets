#! /bin/bash
sudo apt-get update
sudo apt-get install -y 
sudo apt-get update
sudo apt upgrade -y
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo service docker start
sudo apt install docker-compose git httpie jq zip unzip  -y


