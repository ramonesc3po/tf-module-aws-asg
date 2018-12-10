locals {
  requireds_tags_intances_asg = [
    {
      key = "Terraform"
      propagate_at_launch = "true"
      value = "true"
    },
    {
      key = "Organization"
      propagate_at_launch = "true"
      value = "${var.asg_organization}"
    },
    {
      key = "Tier"
      propagate_at_launch = "true"
      value = "${var.asg_tier}"
    }
  ]
}