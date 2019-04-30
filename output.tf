output "max_size" {
  value = "${element(aws_autoscaling_group.this_whitout_lifecycle_hook.*.max_size, 0)}"
}

output "min_size" {
  value = "${element(aws_autoscaling_group.this_whitout_lifecycle_hook.*.min_size, 0)}"
}

output "desired_capacity" {
  value = "${element(aws_autoscaling_group.this_whitout_lifecycle_hook.*.desired_capacity, 0)}"
}

output "name" {
  value = "${element(aws_autoscaling_group.this_whitout_lifecycle_hook.*.name, 0)}"
}

output "target_group_arns" {
  value = "${element(aws_autoscaling_group.this_whitout_lifecycle_hook.*.target_group_arns, 0)}"
}

output "launch_configuration" {
  value = "${element(aws_autoscaling_group.this_whitout_lifecycle_hook.*.launch_configuration, 0)}"
}

output "instance_type" {
  value = "${element(aws_launch_configuration.this.*.instance_type, 0)}"
}

output "launch_configuration_name" {
  value = "${element(aws_launch_configuration.this.*.name, 0)}"
}

output "user_data" {
  value = "${element(aws_launch_configuration.this.*.user_data, 0)}"
}

output "autoscaling_group_id" {
  value = "${element(aws_autoscaling_group.this_whitout_lifecycle_hook.*.id, 0)}"
}

output "launch_configuration_id" {
  value = "${element(aws_launch_configuration.this.*.id, 0)}"
}

output "autoscaling_group_arn" {
  value = "${element(aws_autoscaling_group.this_whitout_lifecycle_hook.*.arn, 0)}"
}
