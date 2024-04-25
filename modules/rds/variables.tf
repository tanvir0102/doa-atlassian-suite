# ---- doa database/variables.tf -----
variable "project" {}
variable "environment" {}
variable "vpc_id" {}
variable "db_private_subnets" {
  type = list
}
variable "db_instance_class" {}
variable "allocated_storage" {}
variable "listening_port" {}
variable "dbname" {
  type = string
}
variable "dbuser" {
  type = string
}
variable "dbpassword" {
  type = string
  sensitive = true
}
variable "db_engine_version" {}
variable "db_identifier" {}
