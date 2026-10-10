variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "vpc_id" {
  description = "VPC the target group belongs to"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnets to place the ALB in (one per AZ)"
  type        = list(string)
}

variable "alb_sg_id" {
  description = "Security group attached to the ALB"
  type        = string
}

variable "app_port" {
  description = "Port the app servers listen on"
  type        = number
}
