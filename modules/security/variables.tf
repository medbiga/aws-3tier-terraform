variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC the security groups belong to"
  type        = string
}

variable "app_port" {
  description = "Port the application listens on"
  type        = number
}

variable "db_port" {
  description = "Port the database listens on"
  type        = number
}
