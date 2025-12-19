resource "aws_sns_topic" "sns_topic" {
  name = "devops-sns-topic"
}

resource "aws_instance" "devops_ec2" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  tags = {
    Name = "devops-ec2"
  }
}

resource "aws_cloudwatch_metric_alarm" "devops_alarm" {
  alarm_name          = "devops-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  period              = "300"
  threshold           = "90"
  statistic           = "Average"
  alarm_description   = "Alarm when CPU exceeds 90%"
  alarm_actions       = [aws_sns_topic.sns_topic.arn]

  metric_name = "CPUUtilization"
  namespace   = "AWS/EC2"

  #   Link alarm to the exact EC2 instance
  dimensions = {
    InstanceId = aws_instance.devops_ec2.id
  }
}

output "KKE_instance_name"{
    value = aws_instance.devops_ec2.tags["Name"]
}

output "KKE_alarm_name"{
    value = aws_cloudwatch_metric_alarm.devops_alarm.alarm_name
}

