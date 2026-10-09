#--- General Configuration ---
variable "name_prefix" {
  description = "Prefix for resource names, e.g. three-tier-dev"
  type        = string
}
#--- VPC Configuration ---
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}
#--- Subnet Configuration ---
variable "public_subnet_cidrs" {
  description = "CIDRs for public subnets, one per AZ"
  type        = list(string)
}

variable "app_subnet_cidrs" {
  description = "CIDRs for private app subnets, one per AZ"
  type        = list(string)
}

variable "db_subnet_cidrs" {
  description = "CIDRs for private DB subnets, one per AZ"
  type        = list(string)
}