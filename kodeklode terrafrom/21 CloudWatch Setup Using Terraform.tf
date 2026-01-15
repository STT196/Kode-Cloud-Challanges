resource "aws_cloudwatch_log_group" "datacenter_log_group" {
    name              = "datacenter-log-group"
    retention_in_days = 14
}

resource "aws_cloudwatch_log_stream" "datacenter_log_stream" {
    name           = "datacenter-log-stream"
    log_group_name = aws_cloudwatch_log_group.datacenter_log_group.name
}