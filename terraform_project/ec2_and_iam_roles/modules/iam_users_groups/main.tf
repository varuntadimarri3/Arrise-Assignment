resource "aws_iam_user" "this" {
  for_each      = var.users
  name          = each.key
  force_destroy = true
}

resource "aws_iam_group" "this" {
  for_each = toset(var.groups)
  name     = each.key
}

resource "aws_iam_user_group_membership" "membership" {
  for_each = var.users
  user     = each.key
  groups   = [aws_iam_group.this[each.value].name]

  depends_on = [
    aws_iam_user.this,
    aws_iam_group.this
  ]
}

resource "aws_iam_policy" "cli_only_access" {
  name        = "CLIOnlyAccessPolicy"
  description = "Allow programmatic access only (no console login)"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid      = "AllowAllCLI",
        Effect   = "Allow",
        Action   = "*",
        Resource = "*"
      },
      {
        Sid      = "DenyConsoleLogin",
        Effect   = "Deny",
        Action   = [
          "iam:CreateLoginProfile",
          "iam:UpdateLoginProfile",
          "iam:DeleteLoginProfile"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_group_policy_attachment" "group1_attach" {
  group      = aws_iam_group.this["group1"].name
  policy_arn = aws_iam_policy.cli_only_access.arn
}

resource "aws_iam_group_policy_attachment" "group_policy_attachment" {
  for_each   = var.groups_with_policies
  group      = aws_iam_group.this[each.key].name
  policy_arn = each.value
}