# security groups are stateful, so we just need to allow inbound traffic that is
# needed for smooth network operations. e.g. source quench, pmtu, ping, etc
# icmp ref: https://www.iana.org/assignments/icmp-parameters/icmp-parameters.xhtml
# icmp ref: https://en.wikipedia.org/wiki/Internet_Control_Message_Protocol
# icmpv6 ref: https://www.iana.org/assignments/icmpv6-parameters/icmpv6-parameters.xhtml
# icmpv6 ref: https://en.wikipedia.org/wiki/Internet_Control_Message_Protocol_for_IPv6

resource "aws_security_group" "icmp" {
  name                    = "${data.terraform_remote_state.vpc.vpc_name}_sg_icmp"
  vpc_id                  = "${data.terraform_remote_state.vpc.vpc_id}"
  revoke_rules_on_delete  = true

  # ref: https://www.terraform.io/docs/configuration/interpolation.html#merge-map1-map2-
  tags = "${merge(map("Name","${data.terraform_remote_state.vpc.vpc_name}_sg_icmp"), var.tags)}"

#### BEGIN ICMPv4 ####

  # allow ping (echo request)
  ingress {
    description       = "Allow ping (echo request)"
    from_port         = 8
    to_port           = 0
    protocol          = "icmp"
    # yes, we are allowing ping from *everywhere*.
    # a quick ping of the host to confirm it is up & reachable is
    # too useful of a trouble-shooting tool to justify restricting ping
    cidr_blocks       = ["0.0.0.0/0"]
  }

  # allow source quench
  ingress {
    description       = "Allow source quench"
    from_port         = 4
    to_port           = 0
    protocol          = "icmp"
    cidr_blocks       = ["0.0.0.0/0"]
  }

  # allow time exceeded
  ingress {
    description       = "Allow time exceeded"
    from_port         = 11
    to_port           = -1
    protocol          = "icmp"
    cidr_blocks       = ["0.0.0.0/0"]
  }

  # allow destination unreachable (include related pmtu code 4)
  ingress {
    description       = "Allow destination unreachable"
    from_port         = 3
    to_port           = -1
    protocol          = "icmp"
    cidr_blocks       = ["0.0.0.0/0"]
  }

  # allow parameter problem
  ingress {
    description       = "Allow parameter problem"
    from_port         = 12
    to_port           = -1
    protocol          = "icmp"
    cidr_blocks       = ["0.0.0.0/0"]
  }

  # allow all icmp from the private subnets
  ingress {
    description      = "Allow ALL ICMP"
    from_port        = -1
    to_port          = -1
    protocol         = "icmp"
    cidr_blocks      = ["${data.terraform_remote_state.vpc.private_subnets}"]
  }

#### END ICMPv4 ####

##########################################################################

#### BEGIN ICMPv6 ####

  # allow ipv6 ping (echo request)
  ingress {
    description       = "Allow ICMPv6 ping aka echo request"
    from_port         = 128
    to_port           = 0
    protocol          = "58"
    # yes, we are allowing ping from *everywhere*.
    # a quick ping of the host to confirm it is up & reachable is
    # too useful of a trouble-shooting tool to justify restricting ping
    ipv6_cidr_blocks  = ["::/0"]
  }

  # allow ipv6 destination unreachable
  ingress {
    description       = "Allow ICMPv6 destination unreachable"
    from_port         = 1
    to_port           = -1
    protocol          = "58"
    ipv6_cidr_blocks  = ["::/0"]
  }

  # allow ipv6 packet too big
  ingress {
    description       = "Allow ICMPv6 packet too big"
    from_port         = 2
    to_port           = 0
    protocol          = "58"
    ipv6_cidr_blocks  = ["::/0"]
  }

  # allow ipv6 time exceeded
  ingress {
    description       = "Allow ICMPv6 time exceeded"
    from_port         = 3
    to_port           = -1
    protocol          = "58"
    ipv6_cidr_blocks  = ["::/0"]
  }

  # allow ipv6 parameter problem
  ingress {
    description       = "Allow ICMPv6 parameter problem"
    from_port         = 4
    to_port           = -1
    protocol          = "58"
    ipv6_cidr_blocks  = ["::/0"]
  }

#### END ICMPv6 ####

}
