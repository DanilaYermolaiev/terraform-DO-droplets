#!/bin/bash
## Docker and some tools


sudo apt install git gnupg packages: nginx nftables apt-transport-https ca-certificates curl gnupg lsb-release unattended-upgrades git  vim  hugo software-properties-common python3  httpie jq   -y

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo service docker start


curl -O https://raw.githubusercontent.com/angristan/wireguard-install/master/wireguard-install.sh
chmod +x wireguard-install.sh

# cat << EOF > docker-compose.yml
# ---
# version: "2.1"
# services:
#   wireguard:
#     image: lscr.io/linuxserver/wireguard:latest
#     container_name: wireguard
#     cap_add:
#       - NET_ADMIN
#       - SYS_MODULE
#     environment:
#       - PUID=1000
#       - PGID=1000
#       - TZ=Etc/UTC
#       - SERVERPORT=51820 #optional
#       - PEERS=1 #optional
#       - PEERDNS=auto #optional
#       - INTERNAL_SUBNET=10.13.13.0 #optional
#       - ALLOWEDIPS=0.0.0.0/0 #optional
#       - PERSISTENTKEEPALIVE_PEERS= #optional
#       - LOG_CONFS=true #optional
#     volumes:
#       - /path/to/appdata/config:/config
#       - /lib/modules:/lib/modules #optional
#     ports:
#       - 51820:51820/udp
#     sysctls:
#       - net.ipv4.conf.all.src_valid_mark=1
#     restart: unless-stopped
# EOF
# docker-compose -f docker-compose.yml up -d
# docker ps -a 
# sleep 10
# docker exec -it wireguard cat /config/peer1/peer1.conf


# git clone https://github.com/TrafeX/docker-wordpress.git
# cd docker-wordpress


