## Terraform Configuration

### Providers

| Provider | Version |
|---|---|
| aws | `~> 4.0` |

### Modules

| Module Name | Source | Version |
|---|---|---|
| gitops | `../../modules/gitops` | `0.1` |
| tenant_vpc1 | `../../modules/vpc` | `0.1` |
| tenant_vpc2 | `../../modules/vpc` | `0.1` |
| eks_vpc | `../../modules/vpc` | `0.1` |
| eks_egress_vpc | `../../modules/vpc` | `0.1` |
| tgw | `../../modules/transit_gw` | `0.1` |

### Inputs

| Input Variable | Description |
|---|---|
| `environment` | `Environment to deploy the resources. This value is fetched from run.sh script` |

### Outputs

| Output Variable | Description |
|---|---|
| `tenant2_vpc_cidr_block` | `Tenant2 vpc cidr block` |
| `tenant1_vpc_cidr_block` | `Tenant1 vpc cidr block` |
| `eks_vpc_vpc_id` | `Eks vpc_id` |
| `eks_vpc_private_subnet_ids` | `Eks vpc private subnet ids` |
| `eks_egress_vpc_private_subnet_ids` | `Eks egress vpc private subnet ids` |
| `eks_egress_vpc_vpc_id` | `Eks egress vpc id` |
| `eks_vpc_cidr_block` | `Eks vpc cidr block` |
| `eks_egress_vpc_public_subnet_ids` | `Eks egress vpc public subnet ids` |
| `eks_egress_vpc_cidr_block` | `Eks egress vpc cidr block` |
| `tenant1_vpc_private_subnet_ids` | `Tenant1 vpc private subnet ids` |
