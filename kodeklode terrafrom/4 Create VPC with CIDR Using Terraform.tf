resource "aws_vpc" "datacenter-vpc"{
    cidr_block = "192.168.0.0/24"
    tags = {
        Name = "nautilus-vpc"
    }
    
}