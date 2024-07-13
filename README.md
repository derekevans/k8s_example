
# k8s_dev
This repo has scripts for setting up Kubernetes on my home lab as well as apps for testing different types of deployments. My home lab is running Ubuntu 22.04.

## Dependencies

## make
Make allows us to run tasks that automate setup and other processes.  To install:

```sh
sudo apt update
sudo apt install build-essential
```

### multipass
Multipass is a tool to generate cloud-style Ubuntu VMs quickly on Linux, macOS, and Windows.  To install:

```sh
snap install multipass
```

## Build
To build the k8s cluster:

```sh
make k8s/build NUM_WORKERS=3 CPUS=2 MEMORY=2G DISK=5G MOUNT_DIR="/path/to/mount/dir"
```

To build the k8s master node with different parameters than the worker nodes:

```sh
make k8s/build/master CPUS=2 MEMORY=2G DISK=10G MOUNT_DIR="/path/to/mount/dir"
```

To build the k8s workers nodes with different parameters than the master node:

```sh
make k8s/build/workers NUM_WORKERS=3 CPUS=2 MEMORY=2G DISK=10G MOUNT_DIR="/path/to/mount/dir"
```

## Docker Registry
The Docker Registry allows for distribution of private Docker Images.  We need a registry so that the Kubernetes cluster can pull images from a single source.  On the host machine (e.g., the home lab machine), install Docker then create the registry:

```sh
docker run -d -p 5000:5000 --name registry registry:2.7
```

With images built on the host, tag them and push them to the registry:

```sh
docker tag k8s-flask:latest localhost:5000/k8s-flask:latest
docker push localhost:5000/k8s-flask:latest
```

From the master/worker nodes, you can then pull the image:

```sh
sudo docker pull HOST_IP:5000/k8s-flask
```

Here, HOST_IP can be determined by running the following on the host machine:

```sh
hostname -I | awk '{print $1}'
```