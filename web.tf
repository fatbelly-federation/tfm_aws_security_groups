resource "aws_security_group" "web" {
  name                    = "${data.terraform_remote_state.vpc.vpc_name}_sg_web"
  description             = "Allow http and https from everywhere"
  vpc_id                  = "${data.terraform_remote_state.vpc.vpc_id}"
  revoke_rules_on_delete  = true

  # ref: https://www.terraform.io/docs/configuration/interpolation.html#merge-map1-map2-
  tags = "${merge(map("Name","${data.terraform_remote_state.vpc.vpc_name}_sg_web"), var.tags)}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port   = 9443
    to_port     = 9443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
  
}
