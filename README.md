install multipass
install make

make k8s/build/master CPUS=2 MEMORY=2G DISK=10G DATA_DIR="/home/lab/Development/k8s_example/data"
make k8s/build NUM_WORKERS=1 CPUS=2 MEMORY=2G DISK=5G DATA_DIR="/home/lab/Development/k8s_example/data"