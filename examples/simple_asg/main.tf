data "aws_ami" "this" {
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_vpc" "this" {
  cidr_block = "10.10.10.0/24"
}

resource "aws_security_group" "this" {
  vpc_id = "${aws_vpc.this.id}"

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
  }

  egress {
    from_port = 0
    protocol = "tcp"
    to_port = 0
  }
}

module "simple_asg" {
  source = "../../"

  lc_name = "zigzaga-${var.tier}"
  instance_type = "t2.micro"
  image_id = "${data.aws_ami.this.id}"

  asg_name         = "webapp"
  asg_organization = "zigzaga"
  asg_tier         = "production"

  min_size         = "0"
  max_size         = "0"
  desired_capacity = "0"

  security_groups = ["${aws_security_group.this.id}"]
}
