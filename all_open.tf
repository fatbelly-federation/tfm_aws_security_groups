####  !!! DANGER !!!  ####
##                      ##
##  ALL PORTS ARE OPEN  ## 
##                      ##
####  !!! DANGER !!!  ####

resource "aws_security_group" "all_open" {
  name                    = "${data.terraform_remote_state.vpc.vpc_name}_sg_all_open"
  description             = "Allow !!! ** ALL ** !!! Traffic"
  vpc_id                  = "${data.terraform_remote_state.vpc.vpc_id}"
  revoke_rules_on_delete  = true

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # ref: https://www.terraform.io/docs/configuration/interpolation.html#merge-map1-map2-
  tags = "${merge(map("Name","${data.terraform_remote_state.vpc.vpc_name}_sg_all_open"), var.tags)}"
  
}