**🧰 Basic Kubernetes (kubectl) Commands**

📋 1. Check Cluster Info


kubectl cluster-info
Displays the cluster's master and services info.

👥 2. View All Nodes

kubectl get nodes
Lists all worker and master nodes in the cluster.

📦 3. List All Pods in All Namespaces

kubectl get pods --all-namespaces
Shows running pods across all namespaces.

📁 4. List Resources (Pods, Deployments, Services)

kubectl get pods
kubectl get deployments
kubectl get svc
Shows basic workloads and networking components.

🚀 5. Create a Deployment

kubectl create deployment nginx --image=nginx
Creates a deployment named nginx with the nginx image.

🌐 6. Expose Deployment as a Service

kubectl expose deployment nginx --port=80 --type=NodePort
Makes the deployment accessible via a NodePort service.

🔄 7. Scale a Deployment

kubectl scale deployment nginx --replicas=3
Scales the number of pods in a deployment.

🔧 8. Apply Configuration from YAML

kubectl apply -f your-file.yaml
Applies configurations defined in a YAML file.

📜 9. Describe a Resource

kubectl describe pod <pod-name>
Shows detailed info about a specific pod or other resource.

🗑️ 10. Delete Resources

Edit
kubectl delete pod <pod-name>
kubectl delete deployment <deployment-name>
Deletes the specified Kubernetes resource.

🧪 11. Run a Temporary Pod

kubectl run -i -t test-pod --image=alpine -- sh
Runs an interactive pod using the Alpine image.

🔍 12. View Pod Logs

kubectl logs <pod-name>
Displays logs for a container in a pod.

📂 13. Get YAML of Any Resource

kubectl get pod <pod-name> -o yaml
Outputs the full YAML configuration of the resource.

