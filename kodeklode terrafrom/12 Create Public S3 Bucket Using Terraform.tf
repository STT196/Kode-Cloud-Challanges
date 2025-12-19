resource "aws_s3_bucket" "nautilus-s3-16965"{
    bucket = "nautilus-s3-16965"
   
}

resource "aws_s3_bucket_public_access_block" "nautilus-s3-public-access" {
    depends_on = [aws_s3_bucket.nautilus-s3-16965]
    bucket = aws_s3_bucket.nautilus-s3-16965.id

    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
}
resource "aws_s3_bucket_acl" "nautilus-s3-acl" {
    depends_on = [aws_s3_bucket.nautilus-s3-16965]
    bucket = aws_s3_bucket.nautilus-s3-16965.id
    acl    = "public-read"
}

resource "aws_s3_bucket_policy" "nautilus-s3-policy" {
    depends_on = [aws_s3_bucket.nautilus-s3-16965]
    bucket = aws_s3_bucket.nautilus-s3-16965.id

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Sid       = "PublicReadGetObject"
                Effect    = "Allow"
                Principal = "*"
                Action    = "s3:GetObject"
                Resource  = "${aws_s3_bucket.nautilus-s3-16965.arn}/*"
            }
        ]
    })
}
 output "s3_bucket_name" {
    value = aws_s3_bucket.nautilus-s3-16965.acl
}