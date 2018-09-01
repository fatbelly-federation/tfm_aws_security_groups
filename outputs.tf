################################# OUTPUTS ######################################

# all_open.tf
output "sg_all_open" {
  value = "${aws_security_group.all_open.id}"
}

# icmp
output "sg_icmp" {
  value = "${aws_security_group.icmp.id}"
}

# ipsec
output "sg_ipsec" {
  value = "${aws_security_group.ipsec.id}"
}

# internal_servers_group
output "internal_servers_group" {
  value = "${aws_security_group.internal_servers.id}"
}

# internal_servers
output "internal_servers_traffic" {
  value = "${aws_security_group.allow_internal_servers.id}"
}

# outbound.tf
output "sg_outbound" {
  value = "${aws_security_group.outbound.id}"
}

# smtp
output "sg_smtp" {
  value = "${aws_security_group.smtp.id}"
}

# ssh
output "sg_ssh" {
  value = "${aws_security_group.ssh.id}"
}

# web
output "sg_web" {
  value = "${aws_security_group.web.id}"
}

