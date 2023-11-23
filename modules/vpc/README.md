## Terraform Configuration

### Providers

| Provider | Version |
|---|---|


### Modules

| Module Name | Source | Version |
|---|---|---|


### Inputs

| Input Variable | Description |
|---|---|
| `public_subnets_cidr` | `CIDR block for Public Subnet` |
| `transit_gateway_id` | `Transit Gateway ID` |
| `environment` | `Deployment Environment` |
| `name` | `Subnets Tag VPC Prefix` |
| `create_private_tgw_routes` | `Create TGW routes in private route table` |
| `private_subnets_cidr` | `CIDR block for Private Subnet` |
| `region` | `AWS Deployment region.` |
| `vpc_name` | `VPC name for flow log prefix` |
| `tags` | `Tags for VPC` |
| `enable_vpc_flow_logs` | `Whether to enable or disable vpc flow logs` |
| `availability_zones` | `AZ in which all the resources will be deployed` |
| `tgw_public_routes` | `Transit Gateway public routes` |
| `enable_nat_gateway` | `Should be true if you want to provision NAT Gateways for each of your private networks` |
| `create_public_tgw_routes` | `Create TGW routes in public route table` |
| `vpc_cidr` | `CIDR block of the vpc` |

### Outputs

| Output Variable | Description |
|---|---|
| `public_route_table_id` | `public_rt_id` |
| `private_subnet_ids` | `private_subnet_id` |
| `public_subnet_ids` | `public_subnet_id` |
| `vpc_id` | `vpc_id` |
| `private_route_table_id` | `private_rt_id` |
| `vpc_cidr` | `Vpc cidr (auto-generated description)` |
