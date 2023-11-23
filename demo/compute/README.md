## Terraform Configuration

### Providers

| Provider | Version |
|---|---|
| aws | `>= 4.47` |
| kubernetes | `>= 2.10` |
| helm | `>= 2.8.0` |
| kubectl | `>= 1.14` |
| external | `2.3.1` |

### Modules

| Module Name | Source | Version |
|---|---|---|
| eks | `terraform-aws-modules/eks/aws` | `~> 19.12` |
| eks_blueprints_addons | `aws-ia/eks-blueprints-addons/aws` | `~> 1.0` |
| fluxcd | `terraform-module/release/helm` | `2.9.0` |
| cilium | `terraform-module/release/helm` | `1.14.0-snapshot.3` |
| tenant_mgmt | `terraform-module/release/helm` | `0.1.0` |
| gitops | `../../modules/gitops` | `0.1` |

### Inputs

| Input Variable | Description |
|---|---|
| `environment` | `Environment to deploy the resources. This value is fetched from run.sh script` |

### Outputs

| Output Variable | Description |
|---|---|
_No outputs defined._
