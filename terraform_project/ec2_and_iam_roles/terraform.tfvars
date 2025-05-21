ami_id = "ami-0953476d60561c955" 

instances = [
  {
    name          = "web-server-1"
    instance_type = "t2.micro"
    volume_type   = "gp2"
    volume_size   = 8
    key_name      = "key1"
  },
  {
    name          = "web-server-2"
    instance_type = "t3.small"
    volume_type   = "gp3"
    volume_size   = 10
    key_name      = "key2"
  },
  {
  name          = "web-server-3"
  instance_type = "m5.large"
  volume_type   = "io1"
  volume_size   = 20
  key_name      = "key3"
  iops          = 100
  },
  {
    name          = "web-server-4"
    instance_type = "t2.medium"
    volume_type   = "gp2"
    volume_size   = 15
    key_name      = "key4"
  },
  {
    name          = "web-server-5"
    instance_type = "t3.micro"
    volume_type   = "gp3"
    volume_size   = 30
    key_name      = "key5"
  }
]

groups = ["group1", "group2"]

users = {
  engine          = "group1"
  ci              = "group1"
  John_Doe        = "group2"
  Aboubacar_Maina = "group2"
}

groups_with_policies = {
  group2 = "arn:aws:iam::aws:policy/AdministratorAccess"
}
