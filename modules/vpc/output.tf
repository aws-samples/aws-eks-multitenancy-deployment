output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "The unique identifier of the created VPC."
}

output "public_subnet_ids" {
  value       = aws_subnet.public_subnet[*].id
  description = "List of IDs for the public subnets created within the VPC."
}

output "private_subnet_ids" {
  value       = aws_subnet.private_subnet[*].id
  description = "List of IDs for the private subnets created within the VPC."
}

output "public_route_table_id" {
  value       = aws_route_table.public[*].id
  description = "ID of the route table associated with the public subnets in the VPC."
}

output "private_route_table_id" {
  value       = aws_route_table.private[*].id
  description = "ID of the route table associated with the private subnets in the VPC."
}

output "vpc_cidr" {
  value       = aws_vpc.vpc.cidr_block
  description = "The CIDR block associated with the VPC, defining the IP address range."
}
