terraform {
  required_version = "<= 0.11.10"
}

resource "aws_launch_configuration" "this" {
  count = "${var.lc_create}"

  name_prefix     = "${var.lc_name}"
  image_id        = "${var.image_id}"
  instance_type   = "${var.instance_type}"
  security_groups = ["${var.security_groups}"]

  user_data                   = "${var.user_data}"
  iam_instance_profile        = "${var.iam_role}"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  enable_monitoring           = "${var.enable_monitoring}"
  ebs_optimized               = "${var.ebs_optimized}"
  root_block_device           = "${var.root_block_device}"
  ebs_block_device            = "${var.ebs_block_device}"
  ephemeral_block_device      = "${var.ephemeral_block_device}"
  spot_price                  = "${var.spot_price}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "this_whitout_lifecycle_hook" {
  count = "${var.asg_create}"

  name             = "${var.asg_name}-asg-${var.asg_tier}"
  max_size         = "${var.max_size}"
  min_size         = "${var.min_size}"
  desired_capacity = "${var.desired_capacity}"

  health_check_type         = "${var.health_check_type}"
  health_check_grace_period = "${var.health_check_grace_period}"
  default_cooldown          = "${var.default_cooldown}"

  launch_configuration = "${var.lc_create ? element(concat(aws_launch_configuration.this.*.name, list("")), 0) : var.lc_without_module_name}"

  vpc_zone_identifier = "${var.vpc_zone_identifier}"

  target_group_arns = "${var.target_group_arns}"

  termination_policies = "${var.termination_policies}"
  force_delete         = "${var.force_delete}"
  enabled_metrics      = "${var.enabled_metrics}"

  tags = ["${concat(var.tags, local.requireds_tags_intances_asg,list(map("key", "Name","propagate_at_launch", "true","value", "${var.asg_name}-${var.asg_tier}")))}"]

  lifecycle {
    create_before_destroy = true
    ignore_changes = ["min_size","desired_capacity"]
  }
}
