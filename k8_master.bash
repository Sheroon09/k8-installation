#!/bin/bash
echo "➡️  Initializing Kubernetes cluster..."
kubeadm init

echo "➡️  Setting up kubeconfig for user: $USER"
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

export KUBECONFIG=$HOME/.kube/config

echo "➡️  Checking node status..."
kubectl get nodes

echo "➡️  Installing Weave Net CNI plugin..."
kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml

echo "➡️  Final cluster node status:"
kubectl get nodes -o wide
