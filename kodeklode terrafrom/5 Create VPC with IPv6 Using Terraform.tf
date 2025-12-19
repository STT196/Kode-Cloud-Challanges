resource "aws_vpc" "main" {
    tags = {
        Name = "datacenter-vpc"
    }
        cidr_block = "10.0.0.0/16"
        assign_generated_ipv6_cidr_block = true
}

output "vpc_id" {
    value = aws_vpc.main.id
}

output "vpc_cidr_block" {
    value = aws_vpc.main.cidr_block
}

output "vpc_ipv6_cidr_block" {
    value = aws_vpc.main.ipv6_cidr_block
}