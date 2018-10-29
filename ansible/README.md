## Project structure
.
 * [environments](./environments) -- Static and Dynamic inventories
   * [production](./environments/production)
   * [staging](./environments/staging)
 * [roles](./roles) -- Roles
   * [app](.roles/app) -- App host provision role
   * [db](./roles/db) -- DB host provision role
   * [nginx](./roles/nginx) -- NGINX installation role
 * [ansible.cfg](./ansible.cfg) -- General config file for ansible
 * [app.yml](./app.yml) -- Playbook for App host provision
 * [db.yml](./db.yml) -- Playbook for DB host provision
 * [deploy.yml](./deploy.yml) -- Playbook for deploy code
 * [packer_reddit_app.yml](./packer_reddit_app.yml) -- Playbook for Packer App AMI build
 * [packer_reddit_db.yml](./packer_reddit_db.yml) -- Playbook for Packer DB AMI build
 * [reddit_app_one_play.yml](./reddit_app_one_play.yml) -- Old main playbook version with all-in-one
 * [reddit_app.json](./reddit_app.json) -- Packer file for App
 * [reddit_db.json](./reddit_db.json) -- Packer file for DB
 * [site.yml](./site.yml) -- Main playbook with imports and roles

## Bake images and deploy simple application with Packer+Terraform+Ansible

- Packer should be installed before

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

- Create all infrastructure from created artifact images via [Terraform](../terraform_structured)
```sh
cd ../terraform_structured
terraform apply
```

- SSH to VM instances and check that Ruby, bundler and MongoDB are installed:
```sh
ssh appuser@<external_ip> -i ~/.ssh/appuser
ruby -v
bundler -v
systemctl status mongod
```

- Create Static inventory for app and db servers (use hosts.example for reference) or use Dynamic (see Appendix A).

- Reddit App provision and deploy playbook. Latest version is defined for dynamic inventory at staging.
If you want to force static inventory then create static hosts from hosts.example and uncomment it in playbooks as well.
```sh
ansible-playbook site.yml
```

- Check that web application is available on HTTP port:
```sh
http://<app_external_ip>:80
```

- Destroy all infrastructure via Terraform:
```sh
cd ../terraform_structured
terraform destroy
```

## Appendix A: GCE dynamic inventory configuration

- Make sure that you have following pip prerequisites installed:
```sh
apache-libcloud
pycrypto
requests
google-auth
```

- Create ansible service account:
```sh
gcloud iam service-accounts create ansible --display-name "Ansible account"
```

- Grant editor role for ansible account in your project:
```sh
gcloud projects add-iam-policy-binding <project_id> \
    --member serviceAccount:ansible@<project_id>.iam.gserviceaccount.com --role roles/editor
```

- Create key.json for ansible account:
```sh
gcloud iam service-accounts keys create key.json \
--iam-account=ansible@<project_id>.iam.gserviceaccount.com
```

- Configure secrets.py with your credentials from key.json, use secrets.py.example for reference.

- Check that Dynamic Inventory is retrieving hosts:
```sh
./gce.py --list
```
- Verify Ansible SSH connection:
```sh
ansible all -i gce.py -m ping
```

- Force clear GCE cache for Google oauth and Ansible if it stucks after infra recreation:
```sh
rm ~/.google_libcloud_auth.*
rm ~/.ansible/tmp/ansible-gce.cache
```
