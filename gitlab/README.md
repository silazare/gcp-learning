## GitLab deployment example on GCE (Terraform + Ansible)

 * [infrastructure](./infrastructure) -- Terraform general configuration
 * [modules](./modules/vpc/main.tf) -- Terraform modules configuration
 * [environments](./environments) -- Ansible inventory
 * [roles](./roles) -- Ansible roles

## Infrastructure creation/destroy

- Terraform should be installed before

- Clone this repository and go to gitlab/infrastructure folder:
```sh
$ git clone https://github.com/silazare/gcp-learning.git
$ cd gcp-learning/gitlab/infrastructure
```

- Initialize GCP cloud provider, modules and remote backend:
```sh
terraform init
```

- Load your local modules into .terraform folder:
```sh
terraform get
```

- Plan and check your changes before create:
```sh
terraform plan
```

- Create resources:
```sh
terraform apply -auto-approve=true
```

- SSH to both VM instance External IP to check connection:
```sh
ssh ubuntu@<external_ip> -i ~/.ssh/ubuntu
```

- Destroy your resources:
```sh
terraform destroy -auto-approve=true
```

## Configuration Management

- Create Dynamic inventory for GCE as described: [here](https://github.com/silazare/gcp-learning/tree/master/ansible#appendix-a-gce-dynamic-inventory-configuration)

- Confirm that VM is accessible after creation:
```sh
cd gcp-learning/gitlab/
ansible all -i environments/gce.py -m ping
```

- Download galaxy [GitLab role](https://github.com/geerlingguy/ansible-role-gitlab) into roles:
```sh
ansible-galaxy install geerlingguy.gitlab -p roles
```

- Run playbook:
```sh
ansible-playbook site.yml
```

- Confirm that web interface is accessible:
```html
https://<external_ip>:8443
```
