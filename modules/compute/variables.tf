variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "app_subnet_ids" {
  description = "Private app subnets the ASG launches servers into"
  type        = list(string)
}

variable "app_sg_id" {
  description = "Security group attached to every app server"
  type        = string
}

variable "target_group_arn" {
  description = "ALB target group the ASG registers servers in"
  type        = string
}

variable "db_secret_arn" {
  description = "Secrets Manager ARN the app servers may read"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance size for the app tier"
  type        = string
}

variable "asg_min_size" {
  description = "Minimum number of app servers"
  type        = number
}

variable "asg_max_size" {
  description = "Maximum number of app servers"
  type        = number
}

variable "asg_desired_capacity" {
  description = "Normal number of app servers"
  type        = number
}
