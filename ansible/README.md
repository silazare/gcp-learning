## Bake images and deploy simple application with Packer+Terraform+Ansible

- Packer should be installed before
- TCP port 9292 should be opened in GCP firewall

- Clone this repository and go to ansible folder:
```sh
$ git clone https://github.com/silazare/gcp-learning.git
$ cd gcp-learning/ansible
```

- Create reddit app image (Ruby), project-id is mandatory input parameter:
```sh
packer build \
-var 'project_id=<your-gcp-project-id>' \
-var 'machine_type=f1-micro' \
-var 'source_image=ubuntu-1604-xenial-v20181004' \
reddit_app.json
```

- Create reddit db image (MongoDB), project-id is mandatory input parameter:
```sh
packer build \
-var 'project_id=<your-gcp-project-id>' \
-var 'machine_type=f1-micro' \
-var 'source_image=ubuntu-1604-xenial-v20181004' \
reddit_db.json
```

- Create all infrastructure from created artifact images via [Terraform](./terraform_structured)
```sh
terraform apply
``

- SSH to VM instances and check that Ruby, bundler and MongoDB are installed:
```sh
ssh appuser@<external_ip> -i ~/.ssh/appuser
ruby -v
bundler -v
systemctl status mongod
```

- Create ansible inventory file for app and db servers.

- Run Reddit App provision and deploy playbook commands one by one:
```sh
ansible-playbook reddit_app.yml --limit db

ansible-playbook reddit_app.yml --limit app --tags app-tag

ansible-playbook reddit_app.yml --limit app --tags deploy-tag
```

- Check that web application is available:
```sh
http://<external_ip>:9292
```

- Create all infrastructure from created artifact images via Terraform:
```sh
terraform destroy
``
