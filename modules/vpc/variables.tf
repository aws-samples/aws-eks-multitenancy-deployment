variable "environment" {
  type        = string
  description = "Specifies the deployment environment (e.g., dev, staging, prod)."
  default     = ""
}

variable "region" {
  type        = string
  description = "AWS region where the resources will be deployed."
  default     = ""
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC to define the IP address range."
  default     = ""
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = "List of CIDR blocks for public subnets within the VPC."
  default     = []
}

variable "private_subnets_cidr" {
  type        = list(any)
  description = "List of CIDR blocks for private subnets within the VPC."
  default     = []
}

variable "availability_zones" {
  type        = list(any)
  description = "List of Availability Zones for resource deployment."
  default     = []
}

variable "tags" {
  type        = map(any)
  description = "A map of tags to assign to the VPC and its sub-resources."
  default     = {}
}

variable "name" {
  type        = string
  description = "Prefix for naming resources, used primarily for subnet naming."
  default     = ""
}

variable "enable_nat_gateway" {
  type        = bool
  default     = false
  description = "Set to true to provision NAT Gateways in the private subnets."
}

variable "tgw_public_routes" {
  type        = map(any)
  description = "A map of public routes for the Transit Gateway."
  default     = {}
}

variable "transit_gateway_id" {
  type        = string
  default     = ""
  description = "ID of the Transit Gateway to be used."
}

variable "create_private_tgw_routes" {
  type        = bool
  default     = false
  description = "Set to true to create Transit Gateway routes in private route tables."
}

variable "create_public_tgw_routes" {
  type        = bool
  default     = false
  description = "Set to true to create Transit Gateway routes in public route tables."
}

variable "vpc_name" {
  type        = string
  default     = ""
  description = "Name of the VPC, used as a prefix for VPC flow logs."
}

variable "enable_vpc_flow_logs" {
  type        = bool
  default     = false
  description = "Set to true to enable VPC flow logs."
}
