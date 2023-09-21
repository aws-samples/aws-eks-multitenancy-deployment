# EKS VPC 
output "eks_vpc_vpc_id" {
  value       = module.eks_vpc.vpc_id
  description = "vpc_id"
}

output "eks_vpc_cidr_block" {
  value = module.eks_vpc.vpc_cidr
}

output "eks_vpc_private_subnet_ids" {
  value = module.eks_vpc.private_subnet_ids
}

# EKS Egress VPC
output "eks_egress_vpc_vpc_id" {
  value = module.eks_egress_vpc.vpc_id
}

output "eks_egress_vpc_public_subnet_ids" {
  value = module.eks_egress_vpc.public_subnet_ids
}

output "eks_egress_vpc_private_subnet_ids" {
  value = module.eks_egress_vpc.private_subnet_ids
}

output "eks_egress_vpc_cidr_block" {
  value = module.eks_egress_vpc.vpc_cidr
}

# Tenant VPCs 
output "tenant1_vpc_cidr_block" {
  value = module.tenant_vpc1.vpc_cidr
}

output "tenant2_vpc_cidr_block" {
  value = module.tenant_vpc2.vpc_cidr
}

output "tenant1_vpc_private_subnet_ids" {
  value = module.tenant_vpc1.private_subnet_ids
}
