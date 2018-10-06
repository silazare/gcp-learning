## VM creation via packer backed base AMI

- Packer should be installed before
- TCP port 9292 should be opened in GCP firewall

- Clone this repository and go to packer folder:
```sh
$ git clone https://github.com/silazare/gcp-learning.git
$ cd gcp-learning/packer
```

- Create reddit base image (Ruby+MongoDB), project-id is mandatory input parameter:
```sh
packer build \
-var 'project_id=<your-gcp-project-id>' \
-var 'machine_type=f1-micro' \
-var 'source_image=ubuntu-1604-xenial-v20181004' \
ubuntu16.json
```

- Create VM instance from created artifact image:
```sh
gcloud compute instances create \
--boot-disk-size=10GB \
--image=<created-image-name> \
--machine-type=g1-small \
--tags puma-server \
--restart-on-failure \
--zone=europe-west1-b reddit-app
```

- SSH to VM instance and install applications via shell/deploy.sh:
```sh
ssh appuser@<external_ip> -i ~/.ssh/appuser
```

- Check web application is available:
```sh
http://<external_ip>:9292
```

- Dont forget to purge created instance and image from GCP:
```sh
gcloud compute instances delete --zone=europe-west1-b reddit-app
gcloud compute images delete <created-image-name>
```

## VM creation via packer backed full AMI

- Create reddit app image (Ruby+MongoDB+application code), project-id is mandatory input parameter:
```sh
packer build \
-var 'project_id=<your-gcp-project-id>' \
-var 'machine_type=f1-micro' \
-var 'source_image=ubuntu-1604-xenial-v20181004' \
immutable.json
```

- Create VM instance from created artifact image:
```sh
gcloud compute instances create \
--boot-disk-size=10GB \
--image=<created-image-name> \
--machine-type=g1-small \
--tags puma-server \
--restart-on-failure \
--zone=europe-west1-b reddit-app
```

- SSH to VM instance and install applications via shell/deploy.sh:
```sh
ssh appuser@<external_ip> -i ~/.ssh/appuser
```

- Check web application is available:
```sh
http://<external_ip>:9292
```

- Dont forget to purge created instance and image from GCP:
```sh
gcloud compute instances delete --zone=europe-west1-b reddit-app
gcloud compute images delete <created-image-name>
```

## Appendix

- Packer commands to check templates before build:
```sh
packer validate ubuntu16.json
packer inspect ubuntu16.json
```

