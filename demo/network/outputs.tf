# EKS VPC 
output "eks_vpc_vpc_id" {
  value       = module.eks_vpc.vpc_id
  description = "The unique identifier of the VPC created for the EKS cluster."
}

output "eks_vpc_cidr_block" {
  value       = module.eks_vpc.vpc_cidr
  description = "The CIDR block associated with the EKS VPC."
}

output "eks_vpc_private_subnet_ids" {
  value       = module.eks_vpc.private_subnet_ids
  description = "List of IDs for the private subnets within the EKS VPC."
}

# EKS Egress VPC
output "eks_egress_vpc_vpc_id" {
  value       = module.eks_egress_vpc.vpc_id
  description = "The unique identifier of the Egress VPC created for the EKS cluster."
}

output "eks_egress_vpc_public_subnet_ids" {
  value       = module.eks_egress_vpc.public_subnet_ids
  description = "List of IDs for the public subnets within the EKS Egress VPC."
}

output "eks_egress_vpc_private_subnet_ids" {
  value       = module.eks_egress_vpc.private_subnet_ids
  description = "List of IDs for the private subnets within the EKS Egress VPC."
}

output "eks_egress_vpc_cidr_block" {
  value       = module.eks_egress_vpc.vpc_cidr
  description = "The CIDR block associated with the EKS Egress VPC."
}

# Tenant VPCs 
output "tenant1_vpc_cidr_block" {
  value       = module.tenant_vpc1.vpc_cidr
  description = "The CIDR block for the Tenant 1 VPC."
}

output "tenant2_vpc_cidr_block" {
  value       = module.tenant_vpc2.vpc_cidr
  description = "The CIDR block for the Tenant 2 VPC."
}

output "tenant1_vpc_private_subnet_ids" {
  value       = module.tenant_vpc1.private_subnet_ids
  description = "List of IDs for the private subnets within the Tenant 1 VPC."
}
