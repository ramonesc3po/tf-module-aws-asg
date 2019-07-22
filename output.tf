output "max_size" {
  value = aws_autoscaling_group.this_whitout_lifecycle_hook[0].max_size
}

output "min_size" {
  value = aws_autoscaling_group.this_whitout_lifecycle_hook[0].min_size
}

output "desired_capacity" {
  value = aws_autoscaling_group.this_whitout_lifecycle_hook[0].desired_capacity
}

output "name" {
  value = aws_autoscaling_group.this_whitout_lifecycle_hook[0].name
}

output "target_group_arns" {
  value = aws_autoscaling_group.this_whitout_lifecycle_hook[0].target_group_arns
}

output "launch_configuration" {
  value = aws_autoscaling_group.this_whitout_lifecycle_hook[0].launch_configuration
}

output "instance_type" {
  value = aws_launch_configuration.this[0].instance_type
}

output "launch_configuration_name" {
  value = aws_launch_configuration.this[0].name
}

output "user_data" {
  value = aws_launch_configuration.this[0].user_data
}

output "autoscaling_group_id" {
  value = aws_autoscaling_group.this_whitout_lifecycle_hook[0].id
}

output "launch_configuration_id" {
  value = aws_launch_configuration.this[0].id
}

output "autoscaling_group_arn" {
  value = aws_autoscaling_group.this_whitout_lifecycle_hook[0].arn
}

