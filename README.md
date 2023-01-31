## Connect to cluster
```bash
aws eks --region us-east-2 update-kubeconfig --name eks-demo-cluster

kubectl api-resources
kubectl get pods
kubectl get po -A
kubectl get nodes -o wide
kubectl get svc

eksctl create cluster --name <cluster name> -region <cluster region>
eksctl get cluster
eksctl delete cluster
```
