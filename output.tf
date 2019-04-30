output "max_size" {
  value = "${aws_autoscaling_group.this_whitout_lifecycle_hook.max_size}"
}

output "min_size" {
  value = "${aws_autoscaling_group.this_whitout_lifecycle_hook.min_size}"
}

output "desired_capacity" {
  value = "${aws_autoscaling_group.this_whitout_lifecycle_hook.desired_capacity}"
}
