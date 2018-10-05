## VM creation with manual shell scripts

- Create SSH key for appuser and add public key to metadata:
```sh
ssh-keygen -t rsa -f ~/.ssh/appuser -C appuser -P ""
```

- Create VM instance:
```sh
gcloud compute instances create \
--boot-disk-size=10GB \
--image=ubuntu-1604-xenial-v20170815a \
--image-project=ubuntu-os-cloud \
--machine-type=g1-small \
--tags puma-server \
--restart-on-failure \
--zone=europe-west1-b reddit-app
```

- Open TCP port 9292 in GCP firewall

- SSH to VM instance:
```sh
ssh appuser@<external_ip> -i ~/.ssh/appuser
```

- Clone this repository and make scripts executable:
```sh
$ git clone https://github.com/silazare/gcp-learning.git
$ cd gcp-learning/shell
$ chmod +x *.sh
```

- Install needed applications step by step by scripts:
```sh
$./install_ruby.sh
$./install_mongodb.sh
$./deploy.sh
```

- Check web application is available:
```sh
http://<external_ip>:9292
```

## VM creation with bootstrap shell script:

- Create VM instance with script from repository:
```sh
gcloud compute instances create \
--boot-disk-size=10GB \
--image=ubuntu-1604-xenial-v20170815a \
--image-project=ubuntu-os-cloud \
--machine-type=g1-small \
--tags puma-server \
--restart-on-failure \
--zone=europe-west1-b reddit-app \
--metadata-from-file startup-script=deploy_application.sh
```

