output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "vpc_id"
}

output "public_subnet_ids" {
  value       = aws_subnet.public_subnet[*].id
  description = "public_subnet_id"
}

output "private_subnet_ids" {
  value       = aws_subnet.private_subnet[*].id
  description = "private_subnet_id"
}

output "public_route_table_id" {
  value       = aws_route_table.public[*].id
  description = "public_rt_id"
}

output "private_route_table_id" {
  value       = aws_route_table.private[*].id
  description = "private_rt_id"
}

output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}
