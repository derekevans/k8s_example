
sh scripts/k8s_install.sh

# Init kubeadm
sudo kubeadm init --cri-socket unix:///var/run/cri-dockerd.sock

# Configure kubectl to work for non-root user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Network
kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
