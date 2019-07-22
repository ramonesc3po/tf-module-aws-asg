resource "aws_launch_configuration" "this" {
  count = var.lc_create

  name_prefix     = var.lc_name
  image_id        = var.image_id
  instance_type   = var.instance_type
  security_groups = var.security_groups

  user_data                   = var.user_data
  iam_instance_profile        = var.iam_role
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  enable_monitoring           = var.enable_monitoring
  ebs_optimized               = var.ebs_optimized
  dynamic "root_block_device" {
    for_each = var.root_block_device
    content {
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
      iops                  = lookup(root_block_device.value, "iops", null)
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", null)
    }
  }
  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device
    content {
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", null)
      device_name           = ebs_block_device.value.device_name
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
      iops                  = lookup(ebs_block_device.value, "iops", null)
      no_device             = lookup(ebs_block_device.value, "no_device", null)
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
    }
  }
  dynamic "ephemeral_block_device" {
    for_each = var.ephemeral_block_device
    content {
      device_name  = ephemeral_block_device.value.device_name
      virtual_name = ephemeral_block_device.value.virtual_name
    }
  }
  spot_price = var.spot_price

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "this_whitout_lifecycle_hook" {
  count = var.asg_create

  name             = "${var.asg_name}-asg-${var.asg_tier}"
  max_size         = var.max_size
  min_size         = var.min_size
  desired_capacity = var.desired_capacity

  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period
  default_cooldown          = var.default_cooldown

  launch_configuration = var.lc_create ? element(concat(aws_launch_configuration.this.*.name, [""]), 0) : var.lc_without_module_name

  vpc_zone_identifier = var.vpc_zone_identifier

  target_group_arns = var.target_group_arns

  termination_policies = var.termination_policies
  force_delete         = var.force_delete
  enabled_metrics      = var.enabled_metrics

  tags = [concat(
    var.tags,
    local.requireds_tags_intances_asg,
    [
      {
        key                 = "Name"
        propagate_at_launch = "true"
        value               = "${var.asg_name}-${var.asg_tier}"
      },
    ],
  )]

  lifecycle {
    create_before_destroy = true
  }
}

