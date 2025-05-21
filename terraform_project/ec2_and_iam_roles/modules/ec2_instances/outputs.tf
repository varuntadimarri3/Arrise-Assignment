output "instance_ids" {
  value = [for instance in aws_instance.this : instance.id]
}

output "public_ips" {
  value = [for instance in aws_instance.this : instance.public_ip]
}
