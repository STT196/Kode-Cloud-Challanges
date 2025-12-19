resource "aws_s3_bucket" "private_bucket" {
  bucket = "devops-s3-26521"
  acl    = "private"

}


