
sh scripts/k8s_install.sh

# Open ports necessary for K8s control plane
# See https://kubernetes.io/docs/reference/networking/ports-and-protocols/#control-plane
sudo ufw allow 6443/tcp
sudo ufw allow 2379:2380/tcp
sudo ufw allow 10250/tcp
sudo ufw allow 10259/tcp
sudo ufw allow 10257/tcp

# Init kubeadm
sudo kubeadm init

# Configure kubectl to work for non-root user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

