variable "instances" {
  description = "EC2 instance configurations"
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
  description = "AMI ID for the EC2 instances"
  type        = string
}
