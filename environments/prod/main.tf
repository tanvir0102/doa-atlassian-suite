# --- root/main.tf --- 

# Deploy Networking Resources
module "network" {
  source                        = "../../modules/network"
  access_ip                     = var.access_ip
  doa_vpc_cidr                  = var.doa_vpc_cidr
  doa_subnet_web01_public_cidr  = var.doa_subnet_web01_public_cidr
  doa_subnet_web02_public_cidr  = var.doa_subnet_web02_public_cidr
  doa_subnet_app01_private_cidr = var.doa_subnet_app01_private_cidr
  doa_subnet_app02_private_cidr = var.doa_subnet_app02_private_cidr
  doa_subnet_db01_private_cidr  = var.doa_subnet_db01_private_cidr
  doa_subnet_db02_private_cidr  = var.doa_subnet_db02_private_cidr
  security_groups               = local.security_groups
  db_subnet_group               = "true"
  project                       = var.project
  environment                   = var.environment
}
