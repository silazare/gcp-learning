## K8s manifests for Reddit App

- Create GKE cluster:
```sh
gcloud container clusters create reddit-cluster \
--num-nodes 2 \
--machine-type g1-small

gcloud container clusters list
```

- Configure kubectl for created cluster and check config:
```sh
cat ~/.kube/config

kubectl config current-context
```

- Create dev namespace:
```sh
kubectl apply -f ../k8s/dev-namespace.yml
```

- Create app resources in dev namespace:
```sh
kubectl apply -f ../k8s/app -n dev
```

