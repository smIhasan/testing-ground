gcloud comput regions list - check valid regions

terraform init - creates the .terraform/ directory as well as .terraform.lock.hcl

terraform fmt - auto-format

terraform validate - checks HCL for errors

terraform plan - compares config to state and plans

terraform apply

terraform destroy - DO NOT FORGET!



Notes:
- Dont make any changes to the infrastructure directly
    - Research options if any changes are made...
- Dont commit any of the following...
    - state files
    - ./terraform
    - terraform.tfvars