resource "aws_instance" "datacenter-ec2" {
    tags = {
        Name = "datacenter-ec2"
    }
    ami = "ami-0c101f26f147fa7fd"
    instance_type = "t2.micro"
    key_name = aws_key_pair.datacenter-key.key_name
    security_groups = ["default"]


}

resource "tls_private_key" "datacenter-key" {
    algorithm = "RSA"
    rsa_bits  = 4096
}

resource "aws_key_pair" "datacenter-key" {
    key_name   = "datacenter-kp"
    public_key = tls_private_key.datacenter-key.public_key_openssh
}