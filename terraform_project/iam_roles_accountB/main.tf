terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_iam_role" "roleC" {
  provider = aws.accountB
  name     = "roleC"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::099066653676:role/roleB"
      #  AWS = "arn:aws:iam::099066653676:user/varun1"
      }
      Action = "sts:AssumeRole"
    }]
  })
}


resource "aws_iam_policy" "s3_access" {
  provider = aws.accountB
  name = "S3AccessPolicy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["s3:*"]
      Resource = ["arn:aws:s3:::aws-test-bucket", "arn:aws:s3:::aws-test-bucket/*", "arn:aws:s3:::varuntestbucket123-accountb", "arn:aws:s3:::varuntestbucket123-accountb/*"]
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attachC" {
  provider = aws.accountB
  role       = aws_iam_role.roleC.name
  policy_arn = aws_iam_policy.s3_access.arn

  depends_on = [
    aws_iam_role.roleC,
    aws_iam_policy.s3_access
  ]
}


