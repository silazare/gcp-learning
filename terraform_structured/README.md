## Project structure
.
 * [main.tf](./main.tf) -- General configuration
 * [vpc.tf](./main.tf) -- VPC configuration
 * [app.tf](./main.tf) -- Configuration for Ruby app VM
 * [db.tf](./main.tf) -- Configuration for MongoDB VM
 * [variables.tf](./variables.tf) -- Input variables
 * [terraform.tfvars.example](./terraform.tfvars.example) -- Example of input variables definition

## Separate VMs creation via terraform

- Terraform should be installed before
- Reddit-db and Reddit-base-app images should be baked before, see [packer](./packer)

- Clone this repository and go to terraform_structured folder:
```sh
$ git clone https://github.com/silazare/gcp-learning.git
$ cd gcp-learning/terraform_structured
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
terraform apply -auto-approve=true
```
