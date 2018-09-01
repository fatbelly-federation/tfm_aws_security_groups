resource "aws_security_group" "ssh" {
  name                    = "${data.terraform_remote_state.vpc.vpc_name}_sg_ssh"
  description             = "Allow ssh on port 22 and port ${var.custom_ssh_port}"
  vpc_id                  = "${data.terraform_remote_state.vpc.vpc_id}"
  revoke_rules_on_delete  = true

  ingress {
    description      = "Allow inbound ssh on port 22"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "Allow inbound ssh on port ${var.custom_ssh_port}"
    from_port        = "${var.custom_ssh_port}"
    to_port          = "${var.custom_ssh_port}"
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # we explicitly add icmp rules here in case we forget to attach the icmp security group
  # explicitly allow ping (echo request)
  ingress {
    from_port        = 8
    to_port          = 0
    protocol         = "icmp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # explicityly allow pmtu related icmp
  ingress {
    from_port        = 3
    to_port          = 4
    protocol         = "icmp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = "${var.tags}"
  
}
