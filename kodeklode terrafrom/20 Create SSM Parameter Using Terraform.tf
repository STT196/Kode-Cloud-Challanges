resource "aws_ssm_parameter" "xfusion-ssm-parameter" {
    name  = "xfusion-ssm-parameter"
    type  = "String"
    value = "xfusion-value"

}

output "ssm_parameter_name" {
    value = aws_ssm_parameter.xfusion-ssm-parameter.name
}   