################################# VARIABLES ######################################

variable "remote_state_bucket" {
  description = "Bucket in that stores the terraform state file in s3"
}

variable "dynamodb_table" {
  description = "The name of the dynamodb table used for locking"
}

variable "primary_state_region" {
  description = "the region that the remote state file resides in"
}


variable "region" {
  description = "AWS region we are performing our actions in"
}

variable "vpc_name" {
  description = "name of the VPC"
}


variable "trusted_subnets" {
  type        = "list"
  description = "list of trusted subnets. typically pulled from parent terraform.tfvars"
  default     = []
}

variable "custom_ssh_port" {
  default     = 32786
  description = "custom port that sshd is listening on"
}

variable "tags" {
  type = "map"
  description = "map(list) of tags to add to everything we create with this module"
  default = {
    "terraform" = "true"
  }
}

