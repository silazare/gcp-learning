## Bake images and deploy simple application with Packer+Ansible+GCP

- Packer should be installed before
- TCP port 9292 should be opened in GCP firewall

- Clone this repository and go to ansible folder:
```sh
$ git clone https://github.com/silazare/gcp-learning.git
$ cd gcp-learning/ansible
```

- Create reddit base image (Ruby+MongoDB), project-id is mandatory input parameter:
```sh
packer build \
-var 'project_id=<your-gcp-project-id>' \
-var 'machine_type=f1-micro' \
-var 'source_image=ubuntu-1604-xenial-v20181004' \
reddit_base.json
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

- SSH to VM instance and check that Ruby, bundler and MongoDB are installed:
```sh
ssh appuser@<external_ip> -i ~/.ssh/appuser
ruby -v
bundler -v
systemctl status mongod
```

- Create ansible inventory file for reddit-app instance and run ansible ping
```sh
cat << EOF > hosts
`echo '[reddit_app]'`
`gcloud compute instances list | egrep 'reddit-app' | awk '{print $5}'| tail -1`
EOF

ansible reddit_app -i hosts -m ping -u appuser --private-key=~/.ssh/appuser
```

- Run Reddit App deploy playbook
```sh
ansible-playbook -u appuser -i hosts reddit_app_deploy.yml --private-key=~/.ssh/appuser
```

- Check that web application is available:
```sh
http://<external_ip>:9292
```

- Dont forget to purge created instance from GCP:
```sh
gcloud compute instances delete --zone=europe-west1-b reddit-app
```
