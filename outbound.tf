resource "aws_security_group" "outbound" {
  name                    = "${data.terraform_remote_state.vpc.vpc_name}_sg_outbound"
  description             = "Allow ** ALL ** OUTBOUND traffic"
  vpc_id                  = "${data.terraform_remote_state.vpc.vpc_id}"
  revoke_rules_on_delete  = true

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }

  tags = "${var.tags}"
  
}