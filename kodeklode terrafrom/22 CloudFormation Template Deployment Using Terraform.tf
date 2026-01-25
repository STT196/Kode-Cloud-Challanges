resource "aws_cloudformation_stack" "nautilus_stack"{
    name = "nautilus-stack"
    template_body = jsonencode({
        AWSTemplateFormatVersion = "2010-09-09"
        Description              = "Nautilus CloudFormation Template"
        Resources = {
            NautilusS3Bucket = {
                Type       = "AWS::S3::Bucket"
                Properties = {
                    BucketName = "nautilus-bucket-5082"
                    VersioningConfiguration = {
                        Status = "Enabled"
                    }
                }
            }
        }
    })
}

resource "aws_s3_bucket" "nautilus_bucket" {
    bucket = "nautilus-bucket-5082"
    acl    = "private"
}

resource "aws_s3_bucket_versioning" "nautilus_bucket_versioning" {
    bucket = aws_s3_bucket.nautilus_bucket.id

    versioning_configuration {
        status = "Enabled"
    }
}