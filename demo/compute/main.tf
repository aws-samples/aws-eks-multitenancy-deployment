module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.12"

  cluster_name                            = local.cluster_name
  cluster_version                         = local.cluster_version
  cluster_endpoint_public_access          = false
  cluster_endpoint_private_access         = true
  manage_aws_auth_configmap               = true
  aws_auth_roles                          = local.aws_auth_roles
  create_cluster_security_group           = true
  create_node_security_group              = false
  kms_key_administrators                  = local.kms_key_administrators
  kms_key_owners                          = local.kms_key_owners
  cluster_security_group_additional_rules = local.cluster_security_group_additional_rules
  cluster_enabled_log_types               = local.cluster_enabled_log_types
  vpc_id                                  = data.terraform_remote_state.network.outputs.eks_vpc_vpc_id
  subnet_ids                              = data.terraform_remote_state.network.outputs.eks_vpc_private_subnet_ids
  control_plane_subnet_ids                = data.terraform_remote_state.network.outputs.eks_vpc_private_subnet_ids
  eks_managed_node_groups                 = local.managed_node_group_config
  tags                                    = local.tags
}

module "eks_blueprints_addons" {
  source  = "aws-ia/eks-blueprints-addons/aws"
  version = "~> 1.0" #ensure to update this to the latest/desired version

  cluster_name      = module.eks.cluster_name
  cluster_endpoint  = module.eks.cluster_endpoint
  cluster_version   = module.eks.cluster_version
  oidc_provider_arn = module.eks.oidc_provider_arn

  eks_addons = {
    coredns = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
  }

  enable_external_secrets             = true
  enable_aws_load_balancer_controller = true
  enable_metrics_server               = true
  aws_load_balancer_controller = {
    set = [
      {
        name  = "vpcId"
        value = data.terraform_remote_state.network.outputs.eks_vpc_vpc_id
      }
    ]
  }
  tags = {
    Environment = var.environment
  }
}

module "gitops" {
  depends_on = [module.eks, module.eks_blueprints_addons]
  source     = "../../modules/gitops"

  repository_name          = "cfg-multi-tenancy-apps"
  repository_description   = "CodeCommit repository for hosting tenant apps"
  iam_user_name            = "fluxcd"
  cluster_secretstore_name = local.cluster_secretstore_name
  region                   = local.region
  cluster_secretstore_sa   = local.cluster_secretstore_sa
  cluster_name             = local.cluster_name
}

module "fluxcd" {
  depends_on = [module.eks_blueprints_addons, module.gitops]
  source     = "terraform-module/release/helm"
  version    = "2.8.0"

  namespace  = "flux"
  repository = "https://fluxcd-community.github.io/helm-charts"

  app = {
    name             = "fluxcd"
    version          = "2.9.0"
    chart            = "flux2"
    force_update     = true
    wait             = false
    recreate_pods    = false
    create_namespace = true
    deploy           = 1
  }
}

module "cilium" {
  depends_on = [module.eks_blueprints_addons]
  source     = "terraform-module/release/helm"
  version    = "2.8.0"

  namespace  = "kube-system"
  repository = "https://helm.cilium.io/"

  app = {
    name          = "cilium"
    version       = "1.14.0-snapshot.3"
    chart         = "cilium"
    force_update  = true
    wait          = false
    recreate_pods = false
    deploy        = 1
  }
  set = [
    {
      name  = "cni.chainingMode"
      value = "aws-cni"
    },
    {
      name  = "cni.exclusive"
      value = false
    },
    {
      name  = "enableIPv4Masquerade"
      value = false
    },
    {
      name  = "routingMode"
      value = "native"
    },
    {
      name  = "endpointRoutes.enabled"
      value = true
    },
  ]
}

module "tenant_mgmt" {
  depends_on = [module.fluxcd, module.cilium]
  source     = "terraform-module/release/helm"
  version    = "2.8.0"

  namespace  = module.gitops.platform_namespace_name
  repository = "local"

  app = {
    name             = "cfg-tenant-mgmt"
    version          = "0.1.0"
    chart            = "${path.module}/k8s/cfg-tenant-mgmt"
    force_update     = true
    create_namespace = true
    wait             = false
    recreate_pods    = false
    deploy           = 1
  }
  values = [templatefile("${path.module}/k8s/cfg-tenant-mgmt/values.yaml", {
    TEANT_BASE_URL     = "ssh://${module.gitops.aws_ssh_public_key_id}@git-codecommit.${local.region}.amazonaws.com/v1/repos/${module.gitops.codecommit_repository_arn}"
    TENANT_REPO_SECRET = "${local.cluster_name}-sm"
  })]
}
