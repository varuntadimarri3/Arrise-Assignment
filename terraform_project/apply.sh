#!/bin/bash

cd ec2_and_iam_roles
terraform init
terraform validate
terraform plan -var-file="terraform.tfvars"  
terraform apply -var-file="terraform.tfvars" -auto-approve &   
PID1=$!
cd ..

cd iam_roles_accountB
terraform init
terraform validate
terraform plan
terraform apply -auto-approve &
PID2=$!
cd ..

# Wait for both jobs to complete
wait $PID1
wait $PID2

echo "Both accounts applies finished."
