# Provision EC2 instance
resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    "sg-5c09911c21f8c3ffa"
  ]

  tags = {
    Name = "xfusion-ec2"
  }
}

resource "aws_ami_from_instance" "xfusion-ec2-ami"{
    name = "xfusion-ec2-ami"
    source_instance_id = aws_instance.ec2.id


}

resource "null_resource" "wait_for_ami" {
  provisioner "local-exec" {
    command = <<EOT
      STATUS=""
      while [ "$STATUS" != "available" ]; do
        STATUS=$(aws ec2 describe-images --image-ids ${aws_ami_from_instance.xfusion-ec2-ami.id} --query 'Images[0].State' --output text)
        echo "Current AMI status: $STATUS"
        if [ "$STATUS" != "available" ]; then
          sleep 10
        fi
      done
      echo "AMI is now available."
    EOT
  }
  depends_on = [aws_ami_from_instance.xfusion-ec2-ami]
}