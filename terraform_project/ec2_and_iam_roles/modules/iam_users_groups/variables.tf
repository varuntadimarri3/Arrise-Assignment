variable "groups" {
  description = "List of IAM groups"
  type        = list(string)
}

variable "users" {
  description = "Map of IAM users to their group name"
  type        = map(string)
}

variable "groups_with_policies" {
  description = "Map of group name to policy ARN"
  type        = map(string)
}
