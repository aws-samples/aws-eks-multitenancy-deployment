module "tenant_vpc1" {
  source                    = "../../modules/vpc"
  region                    = local.region
  environment               = var.environment
  vpc_cidr                  = local.tenant1_vpc_cidr
  private_subnets_cidr      = [for k, v in local.azs : cidrsubnet(local.tenant1_vpc_cidr, 8, k + 10)]
  availability_zones        = local.azs
  name                      = local.tenant1_vpc_name
  create_private_tgw_routes = true
  transit_gateway_id        = module.tgw.ec2_transit_gateway_id
  tags = {
    Name        = local.tenant1_vpc_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

module "tenant_vpc2" {
  source                    = "../../modules/vpc"
  region                    = local.region
  environment               = var.environment
  vpc_cidr                  = local.tenant2_vpc_cidr
  private_subnets_cidr      = [for k, v in local.azs : cidrsubnet(local.tenant2_vpc_cidr, 8, k + 10)]
  availability_zones        = local.azs
  name                      = local.tenant2_vpc_name
  create_private_tgw_routes = true
  transit_gateway_id        = module.tgw.ec2_transit_gateway_id
  tags = {
    Name        = local.tenant2_vpc_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

module "eks_vpc" {
  source                    = "../../modules/vpc"
  region                    = local.region
  environment               = var.environment
  vpc_cidr                  = local.eks_vpc_cidr
  private_subnets_cidr      = [for k, v in local.azs : cidrsubnet(local.eks_vpc_cidr, 8, k + 10)]
  availability_zones        = local.azs
  name                      = local.eks_vpc_name
  create_private_tgw_routes = true
  transit_gateway_id        = module.tgw.ec2_transit_gateway_id
  tags = {
    Name        = local.eks_vpc_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

module "eks_egress_vpc" {
  source                   = "../../modules/vpc"
  region                   = local.region
  environment              = var.environment
  vpc_cidr                 = local.eks_egress_cidr
  public_subnets_cidr      = [for k, v in local.azs : cidrsubnet(local.eks_egress_cidr, 8, k)]
  private_subnets_cidr     = [for k, v in local.azs : cidrsubnet(local.eks_egress_cidr, 8, k + 10)]
  availability_zones       = local.azs
  name                     = local.eks_egress_vpc_name
  enable_nat_gateway       = true
  transit_gateway_id       = module.tgw.ec2_transit_gateway_id
  create_public_tgw_routes = true
  tgw_public_routes = {
    tenant1_vpc = {
      destination_cidr_block = local.tenant1_vpc_cidr
    }
    tenant2_vpc = {
      destination_cidr_block = local.tenant2_vpc_cidr
    }
    eks_vpc = {
      destination_cidr_block = local.eks_vpc_cidr
    }
  }
  tags = {
    Name        = local.eks_egress_vpc_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

################################################################################
# Transit Gateway Module
################################################################################

module "tgw" {
  source = "../../modules/transit_gw"

  name        = local.tgw_name
  description = "My TGW shared with Mutliple VPC"
  # When "true" there is no need for RAM resources if using multiple AWS accounts
  enable_auto_accept_shared_attachments = true

  timeouts = {
    create = "10m" # Increase the create timeout to 10 minutes
  }

  transit_gateway_cidr_blocks = ["10.99.0.0/24"]
  # When "true", allows service discovery through IGMP
  enable_mutlicast_support = false

  vpc_attachments = {
    tenant_vpc1 = {
      vpc_id                                          = module.tenant_vpc1.vpc_id
      subnet_ids                                      = module.tenant_vpc1.private_subnet_ids
      transit_gateway_default_route_table_propagation = true
      dns_support                                     = true
      ipv6_support                                    = false

      tgw_routes = [
        {
          destination_cidr_block = local.tenant1_vpc_cidr
        }
      ]
    },
    tenant_vpc2 = {
      vpc_id                                          = module.tenant_vpc2.vpc_id
      subnet_ids                                      = module.tenant_vpc2.private_subnet_ids
      transit_gateway_default_route_table_propagation = true
      dns_support                                     = true

      tgw_routes = [
        {
          destination_cidr_block = local.tenant2_vpc_cidr
        }
      ]
    },
    eks_vpc = {
      vpc_id                                          = module.eks_vpc.vpc_id
      subnet_ids                                      = module.eks_vpc.private_subnet_ids
      transit_gateway_default_route_table_propagation = true
      dns_support                                     = true

      tgw_routes = [
        {
          destination_cidr_block = local.eks_vpc_cidr
        }
      ]
    },
    eks_egress_vpc = {
      vpc_id                                          = module.eks_egress_vpc.vpc_id
      subnet_ids                                      = module.eks_egress_vpc.private_subnet_ids
      transit_gateway_default_route_table_propagation = true
      dns_support                                     = true

      tgw_routes = [
        {
          destination_cidr_block = local.eks_egress_cidr
        },
        {
          destination_cidr_block = "0.0.0.0/0"
        }
      ]
    }
  }
}
