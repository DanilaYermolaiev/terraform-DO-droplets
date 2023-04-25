#!/bin/bash
############################
#      "export PATH=$PATH:/usr/bin",
#      "chmod +x /tmp/script.sh",
#      "/tmp/script.sh",
#      "sudo kubeadm init --pod-network-cidr=10.244.0.0/16",
#      "mkdir -p $HOME/.kube",
#      "sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config",
#      "sudo chown $(id -u):$(id -g) $HOME/.kube/config"
############################

sudo apt-get update
sudo apt upgrade -y
sudo apt-get install -y apt-transport-https ca-certificates   curl gnupg lsb-release

# Add docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg   | sudo gpg --dearmor   -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add docker apt repository
echo   "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"   | sudo tee /etc/apt/sources.list.d/docker.list

# Fetch the package lists from docker repository
sudo apt-get update

# Install docker and containerd
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose git httpie  jq -y

# Configure docker to use overlay2 storage and systemd
sudo mkdir -p /etc/docker
cat <<EOF | sudo tee /etc/docker/daemon.json
{
    "exec-opts": ["native.cgroupdriver=systemd"],
    "log-driver": "json-file",
    "log-opts": {"max-size": "100m"},
    "storage-driver": "overlay2"
}
EOF

# Restart docker to load new configuration
sudo systemctl restart docker

# Add docker to start up programs
sudo systemctl enable docker

# Allow current user access to docker command line
sudo usermod -aG docker $USER

# Add Kubernetes GPG key
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg  https://packages.cloud.google.com/apt/doc/apt-key.gpg

# Add Kubernetes apt repository
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main"   | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get install -y kubelet kubeadm kubectl

# Prevent them from being updated automatically
sudo apt-mark hold kubelet kubeadm kubectl

# See if swap is enabled
swapon --show

# Turn off swap
sudo swapoff -a

# Disable swap completely
sudo sed -i -e '/swap/d' /etc/fstab
