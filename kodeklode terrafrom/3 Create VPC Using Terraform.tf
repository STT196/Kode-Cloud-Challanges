resource "aws_vpc" "datacenter-vpc"{
    cidr_block = "192.168.1.0/24"
    tags = {
        Name = "datacenter-vpc"
    }
}