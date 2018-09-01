# This defines a security group that can be used to allow
# traffic for the group's members


resource "aws_security_group" "internal_servers" {
  name                    = "${data.terraform_remote_state.vpc.vpc_name}_sg_internal_servers"
  description             = "Grouping of internal servers"
  vpc_id                  = "${data.terraform_remote_state.vpc.vpc_id}"
  revoke_rules_on_delete  = true

    # ref: https://www.terraform.io/docs/configuration/interpolation.html#merge-map1-map2-
  tags = "${merge(map("Name","${data.terraform_remote_state.vpc.vpc_name}_sg_internal_servers"), var.tags)}"
  
  
}
