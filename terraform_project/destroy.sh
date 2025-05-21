#!/bin/bash

cd ec2_and_iam_roles
terraform destroy -auto-approve &   
PID1=$!
cd ..

cd iam_roles_accountB
terraform destroy -auto-approve &
PID2=$!
cd ..

# Wait for both jobs to complete
wait $PID1
wait $PID2

echo "Both account resources destroyed."
