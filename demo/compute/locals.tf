locals {
  region                    = data.aws_region.current.name
  account_id                = data.aws_caller_identity.current.account_id
  backend_bucket_name       = "container-focus-group-tfstate"
  cluster_name              = format("%s-%s-eks-private", var.environment, local.region)
  cluster_version           = "1.26"
  cluster_enabled_log_types = ["audit", "api", "authenticator", "scheduler", "controllerManager"]
  kms_key_administrators    = ["arn:aws:iam::${local.account_id}:role/Admin", "arn:aws:iam::${local.account_id}:role/container-focus-group-role", data.terraform_remote_state.pipeline.outputs.iam_arn]
  kms_key_owners            = ["arn:aws:iam::${local.account_id}:role/Admin", "arn:aws:iam::${local.account_id}:role/container-focus-group-role", data.terraform_remote_state.pipeline.outputs.iam_arn]
  cluster_addons_config = {
    coredns = {
      preserve    = true
      most_recent = true

      timeouts = {
        create = "25m"
        delete = "10m"
      }
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }
  managed_node_group_config = {
    initial = {
      instance_types = ["m5.large"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }
  }

  aws_auth_roles = [
    {
      rolearn  = "arn:aws:iam::${local.account_id}:role/Admin"
      username = "Admin"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::${local.account_id}role/container-focus-group-role"
      username = "container-focus-group-role"
      groups   = ["system:masters"]
    },
  ]

  # Extend cluster security group rules
  cluster_security_group_additional_rules = {
    eks_egress_vpc = {
      description                = "Ingress from Egress VPC CIDR range"
      protocol                   = "-1"
      from_port                  = 0
      to_port                    = 65535
      type                       = "ingress"
      source_node_security_group = false
      cidr_blocks                = [data.terraform_remote_state.network.outputs.eks_egress_vpc_cidr_block]
    },
    eks_vpc = {
      description                = "Ingress from EKS VPC CIDR range"
      protocol                   = "-1"
      from_port                  = 0
      to_port                    = 65535
      type                       = "ingress"
      source_node_security_group = false
      cidr_blocks                = [data.terraform_remote_state.network.outputs.eks_vpc_cidr_block]
    }
  }

  cluster_secretstore_name = "cluster-secretstore-sm"
  cluster_secretstore_sa   = "external-secrets-sa"

  tags = {
    Name        = local.cluster_name
    Environment = var.environment
    Team        = "Focal-Container"
  }
}
