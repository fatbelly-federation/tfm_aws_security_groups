resource "aws_security_group" "ipsec" {
  name                    = "${data.terraform_remote_state.vpc.vpc_name}_sg_ipsec"
  description             = "Allow all inbound IPSec traffic"
  vpc_id                  = "${data.terraform_remote_state.vpc.vpc_id}"
  revoke_rules_on_delete  = true

  ingress {
    description      = "IPSec NAT traversal"
    from_port        = 4500
    to_port          = 4500
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "IPSec NAT traversal"
    from_port        = 4500
    to_port          = 4500
    protocol         = "udp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "isakmp"
    from_port        = 500
    to_port          = 500
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "isakmp"
    from_port        = 500
    to_port          = 500
    protocol         = "udp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "IPSec ESP"
    from_port        = 0
    to_port          = 0
    protocol         = 50
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "IPSec AH"
    from_port        = 0
    to_port          = 0
    protocol         = 51
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = "${var.tags}"
  
}
