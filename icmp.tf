resource "aws_security_group" "icmp" {
  name                    = "${data.terraform_remote_state.vpc.vpc_name}_sg_icmp"
  vpc_id                  = "${data.terraform_remote_state.vpc.vpc_id}"
  revoke_rules_on_delete  = true

  # ref: https://www.terraform.io/docs/configuration/interpolation.html#merge-map1-map2-
  tags = "${merge(map("Name","${data.terraform_remote_state.vpc.vpc_name}_sg_icmp"), var.tags)}"
  
  # allow ping (echo request)
  ingress {
    description       = "Allow ping (echo request)"
    from_port         = 8
    to_port           = 0
    protocol          = "icmp"
    cidr_blocks       = ["0.0.0.0/0"]
  }

  # allow pmtu related icmp
  ingress {
    description       = "Allow PMTU aka Destination Unreachable: Fragmentation Needed and Dont Fragment was Set"
    from_port         = 3
    to_port           = 4
    protocol          = "icmp"
    cidr_blocks       = ["0.0.0.0/0"]
  }

  # allow ipv6 ping (echo request)
  ingress {
    description       = "Allow ICMPv6 ping aka echo request"
    from_port         = 128
    to_port           = 0
    protocol          = "58"
    ipv6_cidr_blocks  = ["::/0"]
  }

  # allow all icmp from the private subnets
  ingress {
    description      = "Allow ALL ICMP"
    from_port        = -1
    to_port          = -1
    protocol         = "icmp"
    cidr_blocks      = ["${data.terraform_remote_state.vpc.private_subnets}"]
  }
  
}
