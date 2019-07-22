##
# Launch Configuration
##
variable "lc_create" {
  description = "Defined if you are going to create the launch configuration"
  default     = true
}

variable "lc_name" {
  description = "Define which name will be used in the launch configuration"
}

variable "image_id" {
  description = "ID of the defined image that you would like to use in the activation setting"
  type        = string
}

variable "instance_type" {
  description = "Defined instance type for these launch configuration"
}

variable "iam_role" {
  description = "Should be use associate iam role, this is optional"
  default     = ""
}

variable "key_name" {
  description = "Define key name that should be use instance "
  default     = ""
}

variable "security_groups" {
  description = "Define a list of security groups that will be associate"
  type        = list(string)
  default     = []
}

variable "associate_public_ip_address" {
  description = "If you want associate a public ip set true"
  default     = false
}

variable "user_data" {
  description = "Provide data for instance start, like as shell scripts and others"
  default     = "  "
}

variable "enable_monitoring" {
  description = "Enable and disable detailed monitoring, this is enable by default"
  default     = true
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  default     = false
}

variable "root_block_device" {
  description = "Customize details about the root block device of the instance"
  default     = []
}

variable "ebs_block_device" {
  description = "Additional EBS block devices to attach to the instance"
  type        = list(string)
  default     = []
}

variable "ephemeral_block_device" {
  description = "Customize Ephemeral volumes on the instance"
  type        = list(string)
  default     = []
}

variable "spot_price" {
  description = "Default: On-demand price) The maximum price to use for reserving spot instances"
  default     = ""
}

variable "lc_without_module_name" {
  description = "If you dont use launch configuration module"
  default     = ""
}

##
# Autoscaling Group
##
variable "asg_create" {
  description = "Defined if you are going to create the launch configuration"
  default     = true
}

variable "asg_name" {
  description = "Define which name will be used in the autoscaling group"
}

variable "asg_organization" {
  description = "Required organization this module apply"
}

variable "asg_tier" {
  description = "Set which environment you that use"
  default     = ""
}

variable "max_size" {
  description = "The maximum size of the auto scale group"
  default     = "0"
}

variable "min_size" {
  description = "The minimum size of the auto scale group"
  default     = "0"
}

variable "desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  default     = "0"
}

variable "vpc_zone_identifier" {
  description = "A list of subnet IDs to launch resources in"
  type        = list(string)
}

variable "target_group_arns" {
  description = "A list of aws_alb_target_group ARNs, for use with Application Load Balancing"
  type        = list(string)
  default     = []
}

variable "termination_policies" {
  description = "A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, Default"
  type        = list(string)
  default     = ["Default"]
}

variable "force_delete" {
  description = "Allows deleting the autoscaling group without waiting for all instances in the pool to terminate. You can force an autoscaling group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling."
  default     = true
}

variable "health_check_type" {
  description = "EC2 or ELB. Controls how health checking is done"
  default     = "EC2"
}

variable "health_check_grace_period" {
  description = "Time (in seconds) after instance comes into service before checking healthTime (in seconds) after instance comes into service before checking health"
  default     = "300"
}

variable "default_cooldown" {
  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
  default     = "300"
}

variable "suspended_processes" {
  description = "A list of processes to suspend for the AutoScaling Group. The allowed values are Launch, Terminate, HealthCheck, ReplaceUnhealthy, AZRebalance, AlarmNotification, ScheduledActions, AddToLoadBalancer. Note that if you suspend either the Launch or Terminate process types, it can prevent your autoscaling group from functioning properly."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Add extra tags"
  type        = list(string)
  default     = []
}

variable "enabled_metrics" {
  description = "A list of metrics to collect. The allowed values are GroupMinSize, GroupMaxSize, GroupDesiredCapacity, GroupInServiceInstances, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances"
  type        = list(string)

  default = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]
}

