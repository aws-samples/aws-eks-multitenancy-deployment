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
| `transit_gateway_cidr_blocks` | `One or more IPv4 or IPv6 CIDR blocks for the transit gateway. Must be a size /24 CIDR block or larger for IPv4, or a size /64 CIDR block or larger for IPv6` |
| `enable_dns_support` | `Should be true to enable DNS support in the TGW` |
| `description` | `Description of the EC2 Transit Gateway` |
| `vpc_attachments` | `Maps of maps of VPC details to attach to TGW. Type 'any' to disable type validation by Terraform.` |
| `tgw_tags` | `Additional tags for the TGW` |
| `amazon_side_asn` | `The Autonomous System Number (ASN) for the Amazon side of the gateway. By default the TGW is created with the current default Amazon ASN.` |
| `tgw_route_table_tags` | `Additional tags for the TGW route table` |
| `timeouts` | `Create, update, and delete timeout configurations for the transit gateway` |
| `enable_mutlicast_support` | `Whether multicast support is enabled` |
| `name` | `Name to be used on all the resources as identifier` |
| `enable_auto_accept_shared_attachments` | `Whether resource attachment requests are automatically accepted` |
| `enable_default_route_table_association` | `Whether resource attachments are automatically associated with the default association route table` |
| `tgw_default_route_table_tags` | `Additional tags for the Default TGW route table` |
| `tgw_vpc_attachment_tags` | `Additional tags for VPC attachments` |
| `transit_gateway_route_table_id` | `Identifier of EC2 Transit Gateway Route Table to use with the Target Gateway when reusing it between multiple TGWs` |
| `create_tgw` | `Controls if TGW should be created (it affects almost all resources)` |
| `enable_vpn_ecmp_support` | `Whether VPN Equal Cost Multipath Protocol support is enabled` |
| `tags` | `A map of tags to add to all resources` |
| `enable_default_route_table_propagation` | `Whether resource attachments automatically propagate routes to the default propagation route table` |

### Outputs

| Output Variable | Description |
|---|---|
| `ec2_transit_gateway_route_table_default_propagation_route_table` | `Boolean whether this is the default propagation route table for the EC2 Transit Gateway` |
| `ec2_transit_gateway_propagation_default_route_table_id` | `Identifier of the default propagation route table` |
| `ec2_transit_gateway_arn` | `EC2 Transit Gateway Amazon Resource Name (ARN)` |
| `ec2_transit_gateway_route_table_propagation` | `Map of EC2 Transit Gateway Route Table Propagation attributes` |
| `ec2_transit_gateway_vpc_attachment_ids` | `List of EC2 Transit Gateway VPC Attachment identifiers` |
| `ec2_transit_gateway_route_table_propagation_ids` | `List of EC2 Transit Gateway Route Table Propagation identifiers` |
| `ec2_transit_gateway_route_table_default_association_route_table` | `Boolean whether this is the default association route table for the EC2 Transit Gateway` |
| `ec2_transit_gateway_route_table_association_ids` | `List of EC2 Transit Gateway Route Table Association identifiers` |
| `ec2_transit_gateway_route_table_association` | `Map of EC2 Transit Gateway Route Table Association attributes` |
| `ec2_transit_gateway_id` | `EC2 Transit Gateway identifier` |
| `ec2_transit_gateway_route_ids` | `List of EC2 Transit Gateway Route Table identifier combined with destination` |
| `ec2_transit_gateway_vpc_attachment` | `Map of EC2 Transit Gateway VPC Attachment attributes` |
| `ec2_transit_gateway_association_default_route_table_id` | `Identifier of the default association route table` |
| `ec2_transit_gateway_route_table_id` | `EC2 Transit Gateway Route Table identifier` |
| `ec2_transit_gateway_owner_id` | `Identifier of the AWS account that owns the EC2 Transit Gateway` |
