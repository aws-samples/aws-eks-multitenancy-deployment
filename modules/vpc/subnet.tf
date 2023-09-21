## PUBLIC SUBNETS
resource "aws_subnet" "public_subnet" {
  vpc_id                          = aws_vpc.vpc.id
  count                           = length(var.public_subnets_cidr)
  cidr_block                      = element(var.public_subnets_cidr, count.index)
  availability_zone               = element(var.availability_zones, count.index)
  map_public_ip_on_launch         = true
  ipv6_native                     = false ## Indicates whether to create an IPv6-only subnet
  assign_ipv6_address_on_creation = false ## Specify true to indicate that network interfaces created in the specified subnet should be assigned an IPv6 address.
  tags = {
    Name                                               = "${var.name}-${element(var.availability_zones, count.index)}-public-subnet"
    Environment                                        = "${var.environment}"
    Tier                                               = "Public"
    "kubernetes.io/role/elb"                           = 1
    "kubernetes.io/cluster/demo-us-west-2-eks-private" = "shared"
  }
}
## PRIVATE SUBNETS
resource "aws_subnet" "private_subnet" {
  vpc_id                          = aws_vpc.vpc.id
  count                           = length(var.private_subnets_cidr)
  cidr_block                      = element(var.private_subnets_cidr, count.index)
  availability_zone               = element(var.availability_zones, count.index)
  map_public_ip_on_launch         = false
  ipv6_native                     = false ## Indicates whether to create an IPv6-only subnet
  assign_ipv6_address_on_creation = false ## Specify true to indicate that network interfaces created in the specified subnet should be assigned an IPv6 address.
  tags = {
    Name                                               = "${var.name}-${element(var.availability_zones, count.index)}-private-subnet"
    Environment                                        = "${var.environment}"
    Tier                                               = "Private"
    "kubernetes.io/role/internal-elb"                  = 1
    "kubernetes.io/cluster/demo-us-west-2-eks-private" = "shared"
  }
}
