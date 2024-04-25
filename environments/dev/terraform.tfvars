# --- Global vars value
aws-infra-profile   = "aws-infra-profile"
project = "doa"
environment = "dev"

# --- Network vars value
doa_vpc_cidr                  = "10.1.0.0/16"
doa_subnet_web01_public_cidr  = "10.1.1.0/24"
doa_subnet_web02_public_cidr  = "10.1.2.0/24"
doa_subnet_app01_private_cidr = "10.1.3.0/24"
doa_subnet_app02_private_cidr = "10.1.4.0/24"
doa_subnet_db01_private_cidr  = "10.1.5.0/24"
doa_subnet_db02_private_cidr  = "10.1.6.0/24"

# --- RDS vars value
listening_port = "5432"
dbname     = "exchange_db"
dbuser     = "exchange_db_user"
dbpassword = "dummyexchange"
allocated_storage = "30"
db_identifier = "postgres-db"
db_instance_class = "db.t3.micro"
db_engine_version = "16"
# --- EC2 vars value
