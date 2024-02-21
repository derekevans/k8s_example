
sh scripts/k8s_install.sh

# Open ports necessary for K8s worker node
# See https://kubernetes.io/docs/reference/networking/ports-and-protocols/#node

sudo ufw allow 10250/tcp
sudo ufw allow 30000:32767/tcp
