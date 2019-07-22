##
#  Get the cloudwatch metrics from:
#
#  https://docs.aws.amazon.com/pt_br/AWSEC2/latest/UserGuide/viewing_metrics_with_cloudwatch.html
##

variable "scale_up_scaling_adjustment" {
  description = "(Optional) The number of instances by which to scale. adjustment_type determines the interpretation of this number (e.g., as an absolute number or as a percentage of the existing Auto Scaling group size). A positive increment adds to the current capacity and a negative value removes from the current capacity."
  default     = 3
}

variable "scale_up_adjustment_type" {
  description = "(Optional) Specifies whether the adjustment is an absolute number or a percentage of the current capacity. Valid values are ChangeInCapacity, ExactCapacity, and PercentChangeInCapacity."
  default     = "ChangeInCapacity"
}

variable "scale_up_policy_type" {
  description = "(Optional) The policy type, either SimpleScaling, StepScaling or TargetTrackingScaling. If this value isnt provided, AWS will default to SimpleScaling"
  default     = "SimpleScaling"
}

variable "scale_up_cooldown" {
  description = "(Optional) The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start."
  default     = "120"
}

variable "scale_down_scaling_adjustment" {
  description = "(Optional) The number of instances by which to scale. adjustment_type determines the interpretation of this number (e.g., as an absolute number or as a percentage of the existing Auto Scaling group size). A positive increment adds to the current capacity and a negative value removes from the current capacity."
  default     = -1
}

variable "scale_down_adjustment_type" {
  description = "(Optional) Specifies whether the adjustment is an absolute number or a percentage of the current capacity. Valid values are ChangeInCapacity, ExactCapacity, and PercentChangeInCapacity."
  default     = "ChangeInCapacity"
}

variable "scale_down_policy_type" {
  description = "(Optional) The policy type, either SimpleScaling, StepScaling or TargetTrackingScaling. If this value isnt provided, AWS will default to SimpleScaling"
  default     = "SimpleScaling"
}

variable "scale_down_cooldown" {
  description = "(Optional) The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start."
  default     = "120"
}

variable "enabled_autoscaling_policy_cpu" {
  default = false
}

# Cloudwatch variables

variable "scale_up_high_cpu_threshold" {
  default = "20"
}

variable "scale_up_high_cpu_period" {
  default = "30"
}

variable "scale_up_high_cpu_evaluation_periods" {
  default = "1"
}

variable "scale_up_high_cpu_statistic" {
  description = "(Optional) The statistic to apply to the alarm's associated metric. Either of the following is supported: SampleCount, Average, Sum, Minimum, Maximum"
  default     = "Average"
}

variable "scale_down_low_cpu_threshold" {
  default = "5"
}

variable "scale_down_low_cpu_period" {
  default = "120"
}

variable "scale_down_low_cpu_evaluation_periods" {
  default = "3"
}

variable "scale_down_low_cpu_statistic" {
  description = "(Optional) The statistic to apply to the alarm's associated metric. Either of the following is supported: SampleCount, Average, Sum, Minimum, Maximum"
  default     = "Average"
}

locals {
  enabled_autoscaling_policy_cpu = var.enabled_autoscaling_policy_cpu == true

  asg_name_this = aws_autoscaling_group.this_whitout_lifecycle_hook[0].name
}

resource "aws_autoscaling_policy" "scale_up" {
  count                  = local.enabled_autoscaling_policy_cpu ? 1 : 0
  name                   = "${var.asg_name}-${var.asg_tier}-scale-up"
  autoscaling_group_name = local.asg_name_this
  scaling_adjustment     = var.scale_up_scaling_adjustment
  adjustment_type        = var.scale_up_adjustment_type
  policy_type            = var.scale_up_policy_type
  cooldown               = var.scale_up_cooldown
}

resource "aws_autoscaling_policy" "scale_down" {
  count                  = local.enabled_autoscaling_policy_cpu ? 1 : 0
  name                   = "${var.asg_name}-${var.asg_tier}-scale-down"
  autoscaling_group_name = local.asg_name_this
  scaling_adjustment     = var.scale_down_scaling_adjustment
  adjustment_type        = var.scale_down_adjustment_type
  policy_type            = var.scale_down_policy_type
  cooldown               = var.scale_down_cooldown
}

resource "aws_cloudwatch_metric_alarm" "scale_up_high_cpu" {
  count               = local.enabled_autoscaling_policy_cpu ? 1 : 0
  alarm_name          = "${var.asg_name}-${var.asg_tier}-high-cpu-scale-up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.scale_up_high_cpu_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.scale_up_high_cpu_period
  statistic           = var.scale_up_high_cpu_statistic
  threshold           = var.scale_up_high_cpu_threshold

  dimensions = {
    AutoScalingGroupName = local.asg_name_this
  }

  alarm_description = "Scale up if the cpu used is above for ${var.scale_up_high_cpu_threshold} for ${var.scale_up_high_cpu_period} seconds"
  alarm_actions     = [aws_autoscaling_policy.scale_up[0].arn]
}

resource "aws_cloudwatch_metric_alarm" "scale_down_low_cpu" {
  count               = local.enabled_autoscaling_policy_cpu ? 1 : 0
  alarm_name          = "${var.asg_name}-${var.asg_tier}-low-cpu-scale-down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = var.scale_down_low_cpu_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.scale_down_low_cpu_period
  statistic           = var.scale_down_low_cpu_statistic
  threshold           = var.scale_down_low_cpu_threshold

  dimensions = {
    AutoScalingGroupName = local.asg_name_this
  }

  alarm_description = "Scale down if the cpu used is below for ${var.scale_down_low_cpu_threshold} for ${var.scale_down_low_cpu_period} seconds"
  alarm_actions     = [aws_autoscaling_policy.scale_down[0].arn]
}

