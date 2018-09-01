resource "aws_security_group" "smtp" {
  name                    = "${data.terraform_remote_state.vpc.vpc_name}_sg_allow_smtp"
  description             = "Allow *INBOUND* SMTP Traffic from everywhere"
  vpc_id                  = "${data.terraform_remote_state.vpc.vpc_id}"
  revoke_rules_on_delete  = true

  ingress {
    description      = "Allow inbound smtp on port 25"
    from_port        = 25
    to_port          = 25
    protocol         = "tcp"
    cidr_blocks      = ["${compact(concat(split(",", data.terraform_remote_state.vpc.vpc_cidr_block), var.trusted_subnets))}"]
  }

  tags = "${var.tags}"
  
}
