resource "aws_instance" "this" {
  for_each = { for inst in var.instances : inst.name => inst }

  ami           = var.ami_id
  instance_type = each.value.instance_type
  key_name      = each.value.key_name

  root_block_device {
    volume_type = each.value.volume_type
    volume_size = each.value.volume_size

    iops        = each.value.volume_type == "io1" ? each.value.iops : null
  }
  
  tags = {
    Name = each.key
  }

  depends_on = [aws_key_pair.generated_keys]
}

resource "tls_private_key" "ec2_keys" {
  for_each = toset(["key1", "key2", "key3", "key4", "key5"])

  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_keys" {
  for_each   = tls_private_key.ec2_keys
  key_name   = each.key
  public_key = each.value.public_key_openssh
}

resource "local_file" "private_keys" {
  for_each = tls_private_key.ec2_keys

  content  = each.value.private_key_pem
  filename = "${path.module}/private_keys/${each.key}.pem"
  file_permission = "0600"
}
