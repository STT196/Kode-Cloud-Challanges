resource "aws_iam_policy" "iampolicy_rose" {
  name        = "iampolicy_rose"
  description = "IAM policy for Rose to allow ec2 console read access"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
          "ec2:GetConsoleOutput",
          "ec2:GetConsoleScreenshot"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}
