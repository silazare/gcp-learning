## VM creation via terraform

- Terraform should be installed before
- Reddit-base image should be baked before, see [packer](./packer)

- Clone this repository and go to terraform folder:
```sh
$ git clone https://github.com/silazare/gcp-learning.git
$ cd gcp-learning/terraform
```

- Check or download GCP cloud provider:
```sh
terraform init
```

- Define your variables in terraform.tfvars (you may use terraform.tfvars.example for reference)

- Plan and check your changes before create:
```sh
terraform plan
```

- Create resources:
```sh
terraform apply
```

- SSH to VM instance IP (from terraform output):
```sh
ssh appuser@<external_ip> -i ~/.ssh/appuser
```

- Check that web application is available:
```sh
http://<external_ip>:9292
```

- Destroy your resources:
```sh
terraform destroy
```

## Additional terraform commands

`terraform show` - display your resources  
`terraform refresh` - refresh your resources  
`terraform output` - check output variables  
`terraform taint google_compute_instance.app` - mark resource to be re-created
`terraform fmt` - format terraform files 
