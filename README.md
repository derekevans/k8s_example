
# k8s_example
This repo simulates deploying a Kubernetes cluster running a Flask app on a Linux machine. Cluster nodes will be virtual machines generated via the mutlipass tool.

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

### Docker Registry
The Docker Registry allows for distribution of private Docker Images.  We need a registry so that the Kubernetes cluster can pull images from a single, private source.  On the host machine, install Docker then create the registry:

```sh
# Install Docker
# See https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
docker run -d -p 5000:5000 --name registry registry:2.7
```

## Build
### Flask App
Build the Flask app image and push it to the Docker Registry:

```sh
make flask
```

### Kubernetes Cluster
To build the Kubernetes cluster:

```sh
make k8s/build NUM_WORKERS=3 CPUS=2 MEMORY=2G DISK=5G
```

To build the Kubernetes master node with different parameters than the worker nodes:

```sh
make k8s/build/master CPUS=2 MEMORY=2G DISK=10G
```

To build the Kubernetes worker nodes with different parameters than the master node:

```sh
make k8s/build/workers NUM_WORKERS=3 CPUS=2 MEMORY=2G DISK=10G
```

## Testing
To test the Kubernetes cluster:

```sh
make flask/ping N_THREADS=8
```

This command sends a GET HTTP request to the Flask app `/hello` endpoint.  This endpoint returns a string indicating the IP of the node that is responding to the request.

```console
Greetings from 10.244.2.3!
Greetings from 10.244.2.6!
Greetings from 10.244.2.4!
Greetings from 10.244.2.3!
Greetings from 10.244.2.4!
Greetings from 10.244.2.3!
Greetings from 10.244.2.6!
Greetings from 10.244.2.3!
```