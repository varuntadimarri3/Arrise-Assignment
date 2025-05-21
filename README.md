# Arrise-Assignment

Modify account Ids before running terraform scripts

1) give execution permission to apply.sh
   Use apply.sh for provisioning resources, it has terraform commands: terraform init, validate, plan and apply
give execution permission to destroy.sh
Use deploy.sh for destroying resources, it has terraform destroy command
or 
you can use
cli commands 
cd ec2_and_iam_roles
terraform init
terraform plan -var-file="terraform.tfvars"  
terraform apply -var-file="terraform.tfvars" -auto-approve

then 
cd ..
cd iam_roles_accountB
terraform init
terraform plan
terraform apply -auto-approve

terraform destroy to destroy resources 

2) give execution permission to script.sh
   Modify bucket name before testing
   Use script.sh for accessing Bucket in account 1111111111 from account 000000000000 instead of cli commands



