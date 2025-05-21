#!/bin/bash

ACCOUNT_A_PROFILE="accountA"  
ROLE_B_ARN="arn:aws:iam::099066653676:role/roleB"
ROLE_C_ARN="arn:aws:iam::502818573099:role/roleC"
BUCKET_NAME="varuntestbucket123-accountb"

echo "Assuming roleB from Account A..."
ASSUME_ROLE_B=$(aws sts assume-role \
  --role-arn "$ROLE_B_ARN" \
  --role-session-name assumeRoleBSession \
  --profile "$ACCOUNT_A_PROFILE" \
  --output json)

AWS_ACCESS_KEY_ID_B=$(echo "$ASSUME_ROLE_B" | jq -r '.Credentials.AccessKeyId')
AWS_SECRET_ACCESS_KEY_B=$(echo "$ASSUME_ROLE_B" | jq -r '.Credentials.SecretAccessKey')
AWS_SESSION_TOKEN_B=$(echo "$ASSUME_ROLE_B" | jq -r '.Credentials.SessionToken')

echo "Assuming roleC from Account B..."
ASSUME_ROLE_C=$(AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID_B \
  AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY_B \
  AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN_B \
  aws sts assume-role \
    --role-arn "$ROLE_C_ARN" \
    --role-session-name assumeRoleCSession \
    --output json)

AWS_ACCESS_KEY_ID_C=$(echo "$ASSUME_ROLE_C" | jq -r '.Credentials.AccessKeyId')
AWS_SECRET_ACCESS_KEY_C=$(echo "$ASSUME_ROLE_C" | jq -r '.Credentials.SecretAccessKey')
AWS_SESSION_TOKEN_C=$(echo "$ASSUME_ROLE_C" | jq -r '.Credentials.SessionToken')

echo "Listing contents of S3 bucket: $BUCKET_NAME"
AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID_C \
AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY_C \
AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN_C \
aws s3 ls "s3://$BUCKET_NAME"
