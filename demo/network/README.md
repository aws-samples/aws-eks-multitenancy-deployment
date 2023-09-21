<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks_egress_vpc"></a> [eks\_egress\_vpc](#module\_eks\_egress\_vpc) | ../../modules/vpc | n/a |
| <a name="module_eks_vpc"></a> [eks\_vpc](#module\_eks\_vpc) | ../../modules/vpc | n/a |
| <a name="module_tenant_vpc1"></a> [tenant\_vpc1](#module\_tenant\_vpc1) | ../../modules/vpc | n/a |
| <a name="module_tenant_vpc2"></a> [tenant\_vpc2](#module\_tenant\_vpc2) | ../../modules/vpc | n/a |
| <a name="module_tgw"></a> [tgw](#module\_tgw) | ../../modules/transit_gw | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment to deploy the resources. This value is fetched from run.sh script | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eks_egress_vpc_cidr_block"></a> [eks\_egress\_vpc\_cidr\_block](#output\_eks\_egress\_vpc\_cidr\_block) | n/a |
| <a name="output_eks_egress_vpc_private_subnet_ids"></a> [eks\_egress\_vpc\_private\_subnet\_ids](#output\_eks\_egress\_vpc\_private\_subnet\_ids) | n/a |
| <a name="output_eks_egress_vpc_public_subnet_ids"></a> [eks\_egress\_vpc\_public\_subnet\_ids](#output\_eks\_egress\_vpc\_public\_subnet\_ids) | n/a |
| <a name="output_eks_egress_vpc_vpc_id"></a> [eks\_egress\_vpc\_vpc\_id](#output\_eks\_egress\_vpc\_vpc\_id) | EKS Egress VPC |
| <a name="output_eks_vpc_cidr_block"></a> [eks\_vpc\_cidr\_block](#output\_eks\_vpc\_cidr\_block) | n/a |
| <a name="output_eks_vpc_private_subnet_ids"></a> [eks\_vpc\_private\_subnet\_ids](#output\_eks\_vpc\_private\_subnet\_ids) | n/a |
| <a name="output_eks_vpc_vpc_id"></a> [eks\_vpc\_vpc\_id](#output\_eks\_vpc\_vpc\_id) | vpc\_id |
| <a name="output_tenant1_vpc_cidr_block"></a> [tenant1\_vpc\_cidr\_block](#output\_tenant1\_vpc\_cidr\_block) | Tenant VPCs |
| <a name="output_tenant1_vpc_private_subnet_ids"></a> [tenant1\_vpc\_private\_subnet\_ids](#output\_tenant1\_vpc\_private\_subnet\_ids) | n/a |
| <a name="output_tenant2_vpc_cidr_block"></a> [tenant2\_vpc\_cidr\_block](#output\_tenant2\_vpc\_cidr\_block) | n/a |
<!-- END_TF_DOCS -->