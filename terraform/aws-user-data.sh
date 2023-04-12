#! /bin/bash
sudo apt-get update
sudo apt-get install -y 
sudo apt-get update
sudo apt upgrade -y
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo service docker start
sudo apt install docker-compose git httpie vim jq zip unzip  -y

echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCP4EoAoLa6rYOwFfdYcsL4RTlExHJnU9OOAsYyIGdhioT3DDYEE637AeDsj1ZxxjeSEPYUTB5/jKEC8U2fyyvY1rGlmUtByscFyLXjhnc/X4BiI2h0ZlYx/OGN8AosbOaWzreMI3i2vDH75BTikgrxiocE/Pk7pGuHBVDWBQk4MCC3yWnF+qclarUGYOy82NDjT3TxkDs9LIBoRwYU0HnK7Ore1WtUPEY9TLFVe9gGMUCFuw+jf/Pg12RPoWxsa55Cl6Sskl3vC8W0eVSg07FRmhhDvm/VA0w5Ak61IZuv17YCudJPAJwxRq0dB7VkoHgcdotEMi3yio53WzJhcjfh" >> file.txt
