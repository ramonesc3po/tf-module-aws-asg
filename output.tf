output "max_size" {
  value = "${aws_autoscaling_group.this_whitout_lifecycle_hook.max_size}"
}

output "min_size" {
  value = "${aws_autoscaling_group.this_whitout_lifecycle_hook.min_size}"
}

output "desired_capacity" {
  value = "${aws_autoscaling_group.this_whitout_lifecycle_hook.desired_capacity}"
}

output "name" {
  value = "${aws_autoscaling_group.this_whitout_lifecycle_hook.name}"
}

output "target_group_arns" {
  value = "${aws_autoscaling_group.this_whitout_lifecycle_hook.target_group_arns}"
}

output "launch_configuration" {
  value = "${aws_autoscaling_group.this_whitout_lifecycle_hook.launch_configuration}"
}

output "instance_type" {
  value = "${aws_launch_configuration.this.instance_type}"
}

output "launch_configuration_name" {
  value = "${aws_launch_configuration.this.name}"
}

output "user_data" {
  value = "${aws_launch_configuration.this.user_data}"
}

output "autoscaling_group_id" {
  value = "${aws_autoscaling_group.this_whitout_lifecycle_hook.id}"
}

output "launch_configuration_id" {
  value = "${aws_launch_configuration.this.id}"
}

output "autoscaling_group_arn" {
  value = "${aws_autoscaling_group.this_whitout_lifecycle_hook.arn}"
}
