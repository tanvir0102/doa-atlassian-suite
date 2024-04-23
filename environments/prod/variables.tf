# --- Global vars
variable "aws_region" {
  default = "us-east-1"
}
variable "aws-infra-profile" {}
variable "access_ip" {}

variable "project" {}
variable "environment" {}

# ---- network variables
variable "doa_vpc_cidr" {}
variable "doa_subnet_web01_public_cidr" {}
variable "doa_subnet_web02_public_cidr" {}
variable "doa_subnet_app01_private_cidr" {}
variable "doa_subnet_app02_private_cidr" {}
variable "doa_subnet_db01_private_cidr" {}
variable "doa_subnet_db02_private_cidr" {}

