## ENV 
variable "environment" {
  type        = string
  description = "Deployment Environment"
  default     = ""
}
variable "region" {
  type        = string
  description = "AWS Deployment region."
  default     = ""
}
## VPC VARIABLES
variable "vpc_cidr" {
  type        = string
  description = "CIDR block of the vpc"
  default     = ""
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Public Subnet"
  default     = []
}

variable "private_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Private Subnet"
  default     = []
}
variable "availability_zones" {
  type        = list(any)
  description = "AZ in which all the resources will be deployed"
  default     = []
}

variable "tags" {
  type        = map(any)
  description = "Tags for VPC"
  default     = {}
}

variable "name" {
  type        = string
  description = "Subnets Tag VPC Prefix"
  default     = ""
}

variable "enable_nat_gateway" {
  type        = bool
  default     = false
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
}

variable "tgw_public_routes" {
  type        = map(any)
  description = "Transit Gateway public routes"
  default     = {}
}

variable "transit_gateway_id" {
  type        = string
  default     = ""
  description = "Transit Gateway ID"
}

variable "create_private_tgw_routes" {
  type        = bool
  default     = false
  description = "Create TGW routes in private route table"
}

variable "create_public_tgw_routes" {
  type        = bool
  default     = false
  description = "Create TGW routes in public route table"
}
