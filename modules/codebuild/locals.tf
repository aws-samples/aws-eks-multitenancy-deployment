data "aws_vpc" "this" {
  count = var.vpc_enabled ? 1 : 0
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnets" "this" {
  count = var.vpc_enabled ? 1 : 0

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this[0].id]
  }

  tags = {
    Tier = "Private"
  }
}

data "aws_security_groups" "this" {
  count = var.vpc_enabled ? 1 : 0
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this[0].id]
  }
}

locals {
  vpc_config = var.vpc_enabled ? [{
    security_group_ids = data.aws_security_groups.this[0].ids
    subnets            = data.aws_subnets.this[0].ids
    vpc_id             = data.aws_vpc.this[0].id
  }] : []
}
