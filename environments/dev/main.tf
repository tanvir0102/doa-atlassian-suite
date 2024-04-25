# --- root/main.tf --- 

# Deploy Networking Resources
module "network" {
  source                        = "../../modules/network"
  doa_vpc_cidr                  = var.doa_vpc_cidr
  doa_subnet_web01_public_cidr  = var.doa_subnet_web01_public_cidr
  doa_subnet_web02_public_cidr  = var.doa_subnet_web02_public_cidr
  doa_subnet_app01_private_cidr = var.doa_subnet_app01_private_cidr
  doa_subnet_app02_private_cidr = var.doa_subnet_app02_private_cidr
  doa_subnet_db01_private_cidr  = var.doa_subnet_db01_private_cidr
  doa_subnet_db02_private_cidr  = var.doa_subnet_db02_private_cidr
  project                       = var.project
  environment                   = var.environment
}

# Deploy Database resources
module "database" {
  source               = "../../modules/rds"
  vpc_id               = module.network.vpc_id
  db_private_subnets   = [module.network.doa_subnet_db01_private_id,module.network.doa_subnet_db02_private_id]
  listening_port       = var.listening_port
  db_instance_class    = "db.t3.micro"
  allocated_storage    = "30"
  dbname               = var.dbname
  dbuser               = var.dbuser
  dbpassword           = var.dbpassword
  db_engine_version    = var.db_engine_version 
  db_identifier        = "doa-db"
  project              = var.project
  environment          = var.environment
}
