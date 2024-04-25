data "aws_subnet" "sub_multi_az_1" {
  vpc_id = var.vpc_id
  state  = "available"
  id = var.db_private_subnets[0]
}

data "aws_subnet" "sub_multi_az_2" {
  vpc_id = var.vpc_id
  state  = "available"
  id = var.db_private_subnets[1]
}


resource "aws_db_subnet_group" "doa_rds_subnetgroup" {
  name       = "${var.project}-rds-subnetgroup-${var.environment}"
  subnet_ids = [data.aws_subnet.sub_multi_az_1.id,data.aws_subnet.sub_multi_az_2.id]
  tags = {
    Name = "${var.project}-rds-postgres-sng-${var.environment}"
  }
}

resource "aws_security_group" "doa_rds_sg" {
  name        = "${var.project}-rds-postgres-sg-${var.environment}"
  description = "Allow access to RDS DB from application servers"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.project}-rds-postgres-sg-${var.environment}"
  }

  ingress {
    from_port       = var.listening_port
    protocol        = "tcp"
    to_port         = var.listening_port
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "doa_rds_db" {
  instance_class         = var.db_instance_class
  allocated_storage      = var.allocated_storage
  engine                 = "postgres"
  engine_version         = var.db_engine_version
  identifier             = "${var.project}-${var.db_identifier}-${var.environment}"
  db_name                = var.dbname
  username               = var.dbuser
  password               = var.dbpassword
  vpc_security_group_ids = [aws_security_group.doa_rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.doa_rds_subnetgroup.name
  skip_final_snapshot    = true
  tags = {
    Name = "${var.project}-postres-db-${var.environment}"
  }
}
