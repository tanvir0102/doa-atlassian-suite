variable "doa_vpc_cidr" {
  type = string  
  description = "cidr block for the VPC"
}

variable "doa_subnet_web01_public_cidr" {}
variable "doa_subnet_web02_public_cidr" {}
variable "doa_subnet_app01_private_cidr" {}
variable "doa_subnet_app02_private_cidr" {}
variable "doa_subnet_db01_private_cidr" {}
variable "doa_subnet_db02_private_cidr" {}

variable "security_groups" {}
variable "db_subnet_group" {}

variable "access_ip" {}
variable "project" {}
variable "environment" {}
