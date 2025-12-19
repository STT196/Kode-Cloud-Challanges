resource "aws_dynamodb_table" "devops_table" {
  name         = var.KKE_TABLE_NAME
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "ID"
  attribute {
    name = "ID"
    type = "S"
  }
}

resource "aws_iam_role" "devops_role" {
  name = var.KKE_ROLE_NAME

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "dynamodb.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "devops_readonly_policy" {
  name        = var.KKE_POLICY_NAME
  description = "IAM policy to allow read to DynamoDB table"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:GetItem",
          "dynamodb:Scan",
          "dynamodb:Query"
        ]
        Effect   = "Allow"
        Resource = aws_dynamodb_table.devops_table.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "devops_role_policy_attach" {
  role       = aws_iam_role.devops_role.name
  policy_arn = aws_iam_policy.devops_readonly_policy.arn
}

variable "KKE_TABLE_NAME" {
  description = "Name of the DynamoDB table"
  type        = string
  default     = "devops-table"
}

variable "KKE_ROLE_NAME"{
    description = "Name of the IAM role"
    type        = string
    default     = "devops-role"
}

variable "KKE_POLICY_NAME"{
    description = "Name of the IAM policy"
    type        = string
    default     = "devops-readonly-policy"
}

output "kke_dynamodb_table"{
    value = aws_dynamodb_table.devops_table.name
}

output "kke_iam_role_name"{
    value = aws_iam_role.devops_role.name
}

output "kke_iam_policy_name"{
    value = aws_iam_policy.devops_readonly_policy.name
}

# .tfvars file content:
KKE_TABLE_NAME = "devops-table"
KKE_ROLE_NAME = "devops-role"
KKE_POLICY_NAME = "devops-readonly-policy"