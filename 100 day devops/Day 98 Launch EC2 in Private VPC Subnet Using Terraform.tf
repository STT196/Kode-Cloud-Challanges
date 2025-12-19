resource "aws_vpc" "nautilus_priv_vpc" {
  tags = {
    Name = "nautilus-priv-vpc"
  }
  cidr_block = var.KKE_VPC_CIDR

}

resource "aws_subnet" "nautilus_priv_subnet" {
  vpc_id     = aws_vpc.nautilus_priv_vpc.id
  cidr_block = var.KKE_SUBNET_CIDR
  tags = {
    Name = "nautilus-priv-subnet"
  }
  map_public_ip_on_launch = false

}

resource "aws_instance" "nautilus_priv_ec2" {
  ami                    = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.nautilus_priv_subnet.id
  vpc_security_group_ids = [aws_security_group.nautilus_priv_sg.id]
  tags = {
    Name = "nautilus-priv-ec2"
  }
  associate_public_ip_address = false
  lifecycle {
    ignore_changes = [
      vpc_security_group_ids,
    ]
  }
}

resource "aws_security_group" "nautilus_priv_sg" {
  name_prefix = "nautilus-priv-sg"
  description = "Security group for private EC2 instance"
  vpc_id      = aws_vpc.nautilus_priv_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.KKE_VPC_CIDR]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  depends_on = [aws_vpc.nautilus_priv_vpc]
}

variable "KKE_VPC_CIDR" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "KKE_SUBNET_CIDR" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

output "KKE_vpc_name" {

  value = aws_vpc.nautilus_priv_vpc.tags["Name"]
}

output "KKE_subnet_name" {
  value = aws_subnet.nautilus_priv_subnet.tags["Name"]
}

output "KKE_ec2_private" {
  value = aws_instance.nautilus_priv_ec2.tags["Name"]
}

output "KKE_vpc_cidr" {
  value = var.KKE_VPC_CIDR
}

output "KKE_subnet_cidr" {
  value = var.KKE_SUBNET_CIDR
}


