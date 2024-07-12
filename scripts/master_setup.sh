
#!/bin/bash

# Args
# $1 - Host IP

echo "Host IP: $1"

sh scripts/k8s_install.sh

# Init kubeadm
sudo kubeadm init --cri-socket unix:///var/run/cri-dockerd.sock

# Configure kubectl to work for non-root user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Network
kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml

# Proxy 
tmux new-session -d -s "kubectl-proxy" kubectl proxy --address 0.0.0.0 --port 8001

# Docker Registry
sudo touch /etc/default/docker
echo "DOCKER_OPTS=\"--config-file=/etc/docker/daemon.json\"" | sudo tee -a /etc/default/docker
sudo touch /etc/docker/daemon.json
echo "{ \"insecure-registries\":[\"$1:5000\"] }" | sudo tee -a /etc/docker/daemon.json
sudo systemctl stop docker
sudo systemctl start docker