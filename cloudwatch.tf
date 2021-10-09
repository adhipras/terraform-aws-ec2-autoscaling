#-------------------------------------------------------------------------------
# CloudWatch Alarms
#-------------------------------------------------------------------------------

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "ec2-cpu-util-high"
  alarm_description   = "This metric monitors EC2 CPU utilization"
  metric_name         = var.metric_name
  statistic           = var.statistic
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = var.threshold
  period              = var.period
  evaluation_periods  = var.evaluation_periods
  namespace           = var.namespace
  alarm_actions       = [aws_autoscaling_policy.scale_up.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ec2.name
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  alarm_name          = "ec2-cpu-util-low"
  alarm_description   = "This metric monitors EC2 CPU utilization"
  metric_name         = var.metric_name
  statistic           = var.statistic
  comparison_operator = "LessThanThreshold"
  threshold           = var.threshold
  period              = var.period
  evaluation_periods  = var.evaluation_periods
  namespace           = var.namespace
  alarm_actions       = [aws_autoscaling_policy.scale_down.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ec2.name
  }
}