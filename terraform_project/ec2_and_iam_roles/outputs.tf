output "instance_ids" {
  value = module.ec2_instances.instance_ids
}

output "public_ips" {
  value = module.ec2_instances.public_ips
}
