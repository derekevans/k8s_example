#!/bin/bash

ip=$(multipass info k8s-master | grep "IPv4" | sed s/'IPv4:'//g | sed s/'\s'//g)
response=$(curl -s $ip:30100)
echo "$response"