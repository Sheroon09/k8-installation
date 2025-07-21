#!/bin/bash

# ----------------------------
# Kubernetes and Containerd Setup Script
# ----------------------------

set -e  # Exit immediately on error

echo "➡️  Disabling swap..."
swapoff -a
sed -e '/swap/ s/^#*/#/' -i /etc/fstab

echo "➡️  Enabling required kernel modules..."
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter

echo "➡️  Configuring sysctl for Kubernetes networking..."
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
EOF

sysctl --system

echo "➡️  Installing dependencies..."
apt update -y
apt install -y curl apt-transport-https vim git wget gnupg2 software-properties-common lsb-release ca-certificates uidmap

echo "➡️  Installing containerd..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
sudo apt-get install -y containerd.io

echo "➡️  Generating default containerd config..."
containerd config default | sudo tee /etc/containerd/config.toml

echo "➡️  Starting and enabling containerd..."
systemctl daemon-reload
systemctl enable --now containerd
systemctl restart containerd

echo "✅  containerd status:"
systemctl status containerd --no-pager

echo "➡️  Adding Kubernetes APT repository..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list

echo "➡️  Installing Kubernetes components..."
apt-get update
sudo apt-get install -y kubelet=1.30.3-1.1 kubeadm=1.30.3-1.1 kubectl=1.30.3-1.1 --allow-change-held-packages
apt-mark hold kubelet kubeadm kubectl

echo "✅ Kubernetes master node is up and running!"
