resource "aws_instance" "datacenter-ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  tags = {
    Name = "datacenter-ec2"
  }
  key_name        = aws_key_pair.datacenter-kp.key_name
  security_groups = ["default"]


}

resource "tls_private_key" "datacenter-kp" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "datacenter-kp" {
  key_name   = "datacenter-kp"
  public_key = tls_private_key.datacenter-kp.public_key_openssh
}

output "instance_id" {
  value = aws_instance.datacenter-ec2.id
}
