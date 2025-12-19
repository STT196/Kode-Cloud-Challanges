resource "aws_iam_policy" "iampolicy_mark" {
    name       = "iampolicy_mark"
    path       = "/"
    description = "IAM policy for Mark's project"
    policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:Describe*",
          "ec2:Get*",
          "ec2:List*",
          "ec2:Search*"
        ],
        "Resource" : "*"
      },
      # Required for the EC2 console to display regions and some service-linked info
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:DescribeRegions",
          "ec2:DescribeAvailabilityZones"
        ],
        "Resource" : "*"
      },
      # Optional but recommended: allows viewing SSM Session Manager history (visible in EC2 console)
      {
        "Effect" : "Allow",
        "Action" : [
          "ssm:DescribeSessions",
          "ssm:GetConnectionStatus",
          "ssm:DescribeInstanceInformation"
        ],
        "Resource" : "*"
      }
    ]
  })
}

# Output the policy ARN (useful for attaching later)
output "ec2_readonly_policy_arn" {
  description = "ARN of the created EC2 read-only IAM policy"
  value       = aws_iam_policy.iampolicy_mark.arn
}