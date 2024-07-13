#!/bin/bash

# Args
# $1 - Host IP

sh scripts/k8s_install.sh $1
sh scripts/worker_join.sh
