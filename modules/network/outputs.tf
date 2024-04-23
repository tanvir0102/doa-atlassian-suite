# --- networking/outputs.tf ---

output "vpc_id" {
  value = aws_vpc.doa_vpc.id
}

output "db_security_group" {
  value = aws_security_group.doa_sg["rds"].id
}

output "public_sg" {
  value = aws_security_group.doa_sg["public"].id
}

output "doa_subnet_web01_public_id" {
  value = aws_subnet.doa_subnet_web01_public.id
}

output "doa_subnet_web02_public_id" {
  value = aws_subnet.doa_subnet_web02_public.id
}

output "doa_subnet_app01_private_id" {
  value = aws_subnet.doa_subnet_app01_private.id
}

output "doa_subnet_app02_private_id" {
  value = aws_subnet.doa_subnet_app02_private.id
}

output "doa_subnet_db01_private_id" {
  value = aws_subnet.doa_subnet_db01_private.id
}

output "doa_subnet_db02_private_id" {
  value = aws_subnet.doa_subnet_db02_private.id
}
