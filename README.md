# 🚀 Kubernetes Cluster Setup Automation By Sheroon Mohammad

![Kubernetes](https://raw.githubusercontent.com/kubernetes/kubernetes/master/logo/logo.png)

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Bash Script](https://img.shields.io/badge/Shell-Bash-yellow.svg)](https://www.gnu.org/software/bash/)
[![Ubuntu](https://img.shields.io/badge/OS-Ubuntu-orange.svg)](https://ubuntu.com/)
[![Kubernetes Version](https://img.shields.io/badge/Kubernetes-1.30.3-blue.svg)](https://kubernetes.io/)

---

## 📋 Overview

This repository contains automation scripts to **prepare Ubuntu nodes and initialize a Kubernetes cluster** with version **1.30.3**.

- `k8_master_worker_preq_script.bash`:  
  Prepares both master and worker nodes by disabling swap, loading required kernel modules, installing containerd and Kubernetes components (`kubelet`, `kubeadm`, `kubectl`).

- `k8_master.bash`:  
  Initializes the Kubernetes control-plane (master node), sets up kubeconfig, and installs the Weave Net CNI plugin.

---

## 🎯 Why Use These Scripts?

- Save time by automating manual setup steps.
- Ensure consistent environment across nodes.
- Deploy a Kubernetes cluster quickly and reliably.

---

## 📦 Prerequisites

- Ubuntu 20.04 or 22.04 server (master & workers)
- Root or sudo access
- Network connectivity between nodes
- Minimum 2 CPUs and 2GB RAM per node

---

## 🚀 Getting Started

## 🚀 git clone the below files 

- [`k8_master_worker_preq_script.bash`](https://github.com/Sheroon09/k8-installation/blob/main/k8_master_worker_preq_script.bash)
- [`k8_master.bash`](https://github.com/Sheroon09/k8-installation/blob/main/k8_master.bash)

### 1. Prepare all nodes (master and workers)

chmod +x k8_master_worker_preq_script.bash
sudo ./k8_master_worker_preq_script.bash

### 2. Initialize the master node

chmod +x k8_master.bash
sudo ./k8_master.bash
This will initialize the Kubernetes control-plane and deploy Weave Net CNI.

### 3. Join worker nodes to the cluster

On the master node, generate the join command:

kubeadm token create $(kubeadm token generate) --print-join-command
You will get an output like:

kubeadm join <master-ip>:6443 --token <token> --discovery-token-ca-cert-hash sha256:<hash>
Run this exact command on each worker node to join the cluster.

🖼️ Architecture Diagram

<img width="1024" height="698" alt="image" src="https://github.com/user-attachments/assets/8eba039b-5420-4221-8e13-42fcbf543f18" />


🔧 Useful Commands

    Check node status:
    
    **kubectl get nodes -o wide**

    Check pods status:

      **kubectl get pods -A**

      
📜 License

This project is licensed under the MIT License - see the LICENSE file for details.

🙌 Contributing

Feel free to fork this repo, create issues or pull requests. Your contributions are welcome!

📚 References

- [`Kubernetes Official Docs`](https://kubernetes.io/docs/home/)

- [`Containerd Docs`](https://containerd.io/docs/)
  
- [`Weave Net CNI`](https://www.weave.works/docs/net/latest/kubernetes/kube-addon/)
