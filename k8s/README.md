## K8s manifests for Reddit App (homework 29)

- Create GKE stack via terraform commands:
```sh
cd k8s/terraform
terraform init
terraform plan
terraform apply
```

- Configure kubectl for GKE (Use Terraform provisioner or gcloud)

- Create k8s dev namespace:
```sh
kubectl apply -f ../k8s/dev-namespace.yaml
```

- Create k8s app resources from target folder in dev namespace:
```sh
kubectl apply -f ../k8s/app -n dev
```

- Check nodes, service port and open app at URL:
```sh
kubectl get nodes -o wide

kubectl describe service ui  -n dev  | grep NodePort

http://<node-ip>:<NodePort>
```

- Delete GKE stack via terraform commands:
```sh
cd k8s/terraform
terraform destroy
```

## Appendix A: gcloud commands

- Create GKE stack via gcloud:
```sh
gcloud container clusters create reddit-cluster \
--num-nodes 2 \
--machine-type g1-small \
  --zone europe-west1-c

gcloud container clusters list
```

- Configure kubectl for created cluster and check config:
```sh
gcloud container clusters get-credentials reddit-cluster --zone europe-west1-c --project <project_id>

cat ~/.kube/config

kubectl config current-context
```

- Delete GKE stack via gcloud:
```sh
gcloud container clusters delete reddit-cluster \
--zone europe-west1-c
```

## Appendix B: k8s dashboard

- Create k8s dashboard:
```sh
kubectl apply -f ../k8s/dashboard.yaml -n kube-system
```
- Start proxy and open at URL:
```sh
kubectl proxy

http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
```