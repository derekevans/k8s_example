#!/bin/bash

# Args
# $1 - Host IP

sh scripts/k8s_install.sh $1

# Init kubeadm
sudo kubeadm init --cri-socket unix:///var/run/cri-dockerd.sock --pod-network-cidr=10.244.0.0/16

# Configure kubectl to work for non-root user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
