resource "aws_ebs_volume" "xfusion-volume" {
    tags = {
        Name = "xfusion-volume"
    }
    type = "gp3"
    size = 2
    availability_zone = "us-east-1a"


}