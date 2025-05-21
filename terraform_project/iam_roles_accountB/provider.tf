provider "aws" {
  alias  = "accountB"
  region = "us-east-1"
  profile = "accountB"

  assume_role {
    role_arn = "arn:aws:iam::502818573099:role/roleBB"
    session_name = "TerraformCrossAccountSession"
  }
}