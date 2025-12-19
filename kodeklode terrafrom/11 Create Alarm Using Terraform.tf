resource "aws_cloudwatch_metric_alarm" "nautilus-alarm" {
    alarm_name          = "nautilus-alarm"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods  = "1"
    metric_name         = "CPUUtilization"
    namespace           = "AWS/EC2"
    period              = "300"
    statistic           = "Average"
    threshold           = "80"
    datapoints_to_alarm = 1

}