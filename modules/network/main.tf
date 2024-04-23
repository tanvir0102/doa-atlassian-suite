# ---- IAC networking/main.tf -----

data "aws_availability_zones" "available" {}

resource "aws_vpc" "doa_vpc" {
  cidr_block           = var.doa_vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project}-vpc-${var.environment}"
    Environment = var.environment
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "doa_subnet_web01_public" {
  vpc_id                  = aws_vpc.doa_vpc.id
  cidr_block              = var.doa_subnet_web01_public_cidr
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "${var.project}-subnet-web01-public-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_subnet" "doa_subnet_web02_public" {
  vpc_id                  = aws_vpc.doa_vpc.id
  cidr_block              = var.doa_subnet_web02_public_cidr
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "${var.project}-subnet-web02-public-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_subnet" "doa_subnet_app01_private" {
  vpc_id                  = aws_vpc.doa_vpc.id
  cidr_block              = var.doa_subnet_app01_private_cidr
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "${var.project}-doa-subnet-app01-private-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_subnet" "doa_subnet_app02_private" {
  vpc_id                  = aws_vpc.doa_vpc.id
  cidr_block              = var.doa_subnet_app02_private_cidr
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "${var.project}-subnet-app02-private-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_subnet" "doa_subnet_db01_private" {
  vpc_id                  = aws_vpc.doa_vpc.id
  cidr_block              = var.doa_subnet_db01_private_cidr
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "${var.private}-doa-subnet-db01-private-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_subnet" "doa_subnet_db02_private" {
  vpc_id                  = aws_vpc.doa_vpc.id
  cidr_block              = var.doa_subnet_db02_private_cidr
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "${var.project}-doa-subnet-db02-private-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "doa_internet_gateway" {
  vpc_id = aws_vpc.doa_vpc.id

  tags = {
    Name = "${var.project}-igw-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_route_table" "doa_public_rt" {
  vpc_id = aws_vpc.doa_vpc.id

  tags = {
    Name = "${var.project}-rt-public-${var.environment}"
    Environment = var.environment
  }
}


resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.doa_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.doa_internet_gateway.id
}


resource "aws_route_table_association" "to_doa_subnet_web01_public" {
  subnet_id      = aws_subnet.doa_subnet_web01_public.id
  route_table_id = aws_route_table.doa_public_rt.id
}

resource "aws_route_table_association" "to_doa_subnet_web02_public" {
  subnet_id      = aws_subnet.doa_subnet_web02_public.id
  route_table_id = aws_route_table.doa_public_rt.id
}

resource "aws_route_table" "doa_private_rt" {
  vpc_id = aws_vpc.doa_vpc.id
  
  tags = {
    Name = "${var-project}-rt-private-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "to_doa_subnet_app01_private" {
  subnet_id      = aws_subnet.doa_subnet_app01_private.id
  route_table_id = aws_route_table.doa_private_rt.id
}

resource "aws_route_table_association" "to_doa_subnet_app02_private" {
  subnet_id      = aws_subnet.doa_subnet_app02_private.id
  route_table_id = aws_route_table.doa_private_rt.id
}

resource "aws_route_table_association" "to_doa_subnet_db01_private" {
  subnet_id      = aws_subnet.doa_subnet_db01_private.id
  route_table_id = aws_route_table.doa_private_rt.id
}

resource "aws_route_table_association" "to_doa_subnet_db02_private" {
  subnet_id      = aws_subnet.doa_subnet_db02_private.id
  route_table_id = aws_route_table.doa_private_rt.id
}

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.doa_private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.doa_ngw.id
}

resource "aws_eip" "doa_nat_eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.doa_internet_gateway]
}

resource "aws_nat_gateway" "doa_ngw" {
  allocation_id = aws_eip.doa_nat_eip.id
  subnet_id     = aws_subnet.doa_subnet_web02_public.id
  depends_on = [aws_internet_gateway.doa_internet_gateway]

  tags = {
    Name = "${var.project}-ngw-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_security_group" "doa_sg" {
  for_each    = var.security_groups
  name        = each.value.name
  description = each.value.description
  vpc_id      = aws_vpc.doa_vpc.id



# public Security Group
  dynamic "ingress" {
    for_each = each.value.ingress
    content {
      from_port   = ingress.value.from
      to_port     = ingress.value.to
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
