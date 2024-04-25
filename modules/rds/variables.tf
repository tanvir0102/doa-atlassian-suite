variable "name_tag" {
  description = "Used for tagging all instance-related resources"
}
variable "doa_vpc_id" {}
variable "doa_db_private_subnets" {
  type = "list"
}
variable "listening_port" {
  description = "DB listening port"
}
variable "allowed_sgs" {
  description = "Used to allow other security groups to connect this DB"
  type = "list"
}
variable "instance_class" {}
variable "engine" {}
variable "allocated_storage" {}
variable "db_credentials" {
  type = "list"
}
