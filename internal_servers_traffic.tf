# this security group allows all traffic from
# members of the internal_servers group

resource "aws_security_group" "allow_internal_servers" {
  name                    = "${data.terraform_remote_state.vpc.vpc_name}_sg_allow_internal_servers"
  description             = "Allow ** ALL ** traffic between members of the internal_servrs security group"
  vpc_id                  = "${data.terraform_remote_state.vpc.vpc_id}"
  revoke_rules_on_delete  = true

  # ref: https://www.terraform.io/docs/configuration/interpolation.html#merge-map1-map2-
  tags = "${merge(map("Name","${data.terraform_remote_state.vpc.vpc_name}_sg_allow_internal_servers"), var.tags)}"
  
  ingress {
    description = "Allow all"
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    security_groups = [ "${aws_security_group.internal_servers.id}"]
  }

  ingress {
    description      = "IPSec ESP"
    from_port        = 0
    to_port          = 0
    protocol         = 50
    security_groups = [ "${aws_security_group.internal_servers.id}"]
  }

  ingress {
    description      = "IPSec AH"
    from_port        = 0
    to_port          = 0
    protocol         = 51
    security_groups = [ "${aws_security_group.internal_servers.id}"]
  }

  egress {
    from_port        = "0"
    to_port          = "0"
    protocol         = "-1"
    security_groups = [ "${aws_security_group.internal_servers.id}"]
  }

  
}

