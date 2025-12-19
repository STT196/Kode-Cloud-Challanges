resource "aws_eip" "devops-eip" {
    tags = {
        Name = "devops-eip"
    }
}