module "ec2_instances" {
  source   = "./modules/ec2_instances"
  instances = var.instances
  ami_id    = var.ami_id
}

module "iam_users_groups" {
  source         = "./modules/iam_users_groups"
  groups         = var.groups
  users          = var.users
  groups_with_policies = var.groups_with_policies

}

module "iam_roles_000000000000" {
  source = "./modules/iam_roles_accountA"
}

