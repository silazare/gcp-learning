## K8s manifests for Reddit App

- Create GKE stack via terraform commands:
```sh
cd k8s/terraform
terraform init
terraform plan
terraform apply
```

- Create k8s dev namespace:
```sh
kubectl apply -f k8s/dev-namespace.yml
```

- Create k8s app resources from target folder in dev namespace:
```sh
kubectl apply -f k8s/app -n dev
```

- Create k8s dashboard:
```sh
kubectl apply -f k8s/dashboard.yml -n kube-system
```

- Check nodes, service port and open app at http://<node-ip>:<NodePort>
```sh
kubectl get nodes -o wide

kubectl describe service ui  -n dev  | grep NodePort
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
  --zone us-west1-b

gcloud container clusters list
```

- Configure kubectl for created cluster and check config:
```sh
gcloud container clusters get-credentials reddit-cluster --zone us-west1-b --project <project_id>

cat ~/.kube/config

kubectl config current-context
```

- Delete GKE stack via gcloud:
```sh
gcloud container clusters delete reddit-cluster \
--zone us-west1-b
```