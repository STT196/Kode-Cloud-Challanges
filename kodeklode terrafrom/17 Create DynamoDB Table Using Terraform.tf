resource "aws_dynamodb_table" "devops_users"{
    name = "devops-users"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "devops_id"
    attribute {
        name = "devops_id"
        type = "S"
    }
}