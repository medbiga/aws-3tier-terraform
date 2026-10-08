#------------- variables for the project -------------

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

# ------------- cird blocks for VPC and subnets -------------

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets (web tier), one per AZ"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "app_subnet_cidrs" {
  description = "CIDR blocks for private app subnets, one per AZ"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "db_subnet_cidrs" {
  description = "CIDR blocks for private database subnets, one per AZ"
  type        = list(string)
  default     = ["10.0.21.0/24", "10.0.22.0/24"]
}

# ------------- ports for the application and database -------------
variable "app_port" {
  description = "Port the application listens on"
  type        = number
  default     = 80
}

variable "db_port" {
  description = "Port the database listens on (MySQL)"
  type        = number
  default     = 3306
}

# ------------- EC2 instance and ASG settings -------------
variable "instance_type" {
  description = "EC2 instance size for the app tier"
  type        = string
  default     = "t3.micro"
}

variable "asg_min_size" {
  description = "Minimum number of app servers"
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "Maximum number of app servers"
  type        = number
  default     = 4
}

variable "asg_desired_capacity" {
  description = "Normal number of app servers"
  type        = number
  default     = 2
}