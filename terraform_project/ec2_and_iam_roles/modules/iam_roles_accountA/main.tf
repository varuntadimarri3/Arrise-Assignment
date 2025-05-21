provider "aws" {
  alias   = "accountA"
  region  = "us-east-1"
  profile = "accountA"
}

resource "aws_iam_role" "roleA" {
  provider = aws.accountA
  name = "roleA"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        AWS = "*"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "policy_roleA" {
  provider = aws.accountA
  name        = "Policy-RoleA"
  description = "Admin access excluding IAM"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = "*"
      Resource = "*"
      Condition = {
        StringNotEqualsIfExists = {
          "aws:RequestedService" = "iam"
        }
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attachA" {
  provider = aws.accountA
  role       = aws_iam_role.roleA.name
  policy_arn = aws_iam_policy.policy_roleA.arn

  depends_on = [
    aws_iam_role.roleA,
    aws_iam_policy.policy_roleA
  ]
}

resource "aws_iam_role" "roleB" {
  provider = aws.accountA
  name = "roleB"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
       Principal = {
      "AWS" = "arn:aws:iam::099066653676:user/varun1"
     # AWS = "arn:aws:iam::502818573099:user/varun2"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "policy_roleB" {
  provider = aws.accountA
  name = "Policy-RoleB"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      
      Action = "sts:AssumeRole"
      Resource = "arn:aws:iam::502818573099:role/roleC"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attachB" {
  provider = aws.accountA
  role       = aws_iam_role.roleB.name
  policy_arn = aws_iam_policy.policy_roleB.arn

  depends_on = [
    aws_iam_role.roleB,
    aws_iam_policy.policy_roleB
  ]
}
