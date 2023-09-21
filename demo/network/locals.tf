locals {
  region              = data.aws_region.current.name
  tgw_name            = format("%s-multi-vpc-tgw", var.environment)
  tenant1_vpc_name    = format("%s-tenant1-vpc", var.environment)
  tenant2_vpc_name    = format("%s-tenant2-vpc", var.environment)
  eks_vpc_name        = format("%s-eks-vpc", var.environment)
  eks_egress_vpc_name = format("%s-eks-eg-vpc", var.environment)

  tenant1_vpc_cidr = "10.10.0.0/16"
  tenant2_vpc_cidr = "10.20.0.0/16"
  eks_vpc_cidr     = "10.30.0.0/16"
  eks_egress_cidr  = "10.40.0.0/16"
  azs              = slice(data.aws_availability_zones.available.names, 0, 3)
}
