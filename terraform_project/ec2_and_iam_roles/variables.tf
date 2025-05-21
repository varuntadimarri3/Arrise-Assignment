variable "instances" {
  description = "EC2 instance configs"
  type = list(object({
    name          = string
    instance_type = string
    volume_type   = string
    volume_size   = number
    key_name      = string
    iops          = optional(number)
  }))
}


variable "ami_id" {
  description = "AMI ID for the instances"
  type        = string
}

variable "groups" {
  type = list(string)
}

variable "users" {
  type = map(string)
}

variable "groups_with_policies" {
  description = "Map of group name to policy ARN"
  type        = map(string)
}
