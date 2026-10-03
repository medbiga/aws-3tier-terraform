variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "three-tier-architecture"
}

variable "environment" {
  description = "Environment name for resource naming"
  type        = string
  default     = "dev"
}

