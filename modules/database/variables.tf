variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "db_subnet_ids" {
  description = "Private DB subnets for the DB subnet group (at least 2 AZs)"
  type        = list(string)
}

variable "db_sg_id" {
  description = "Security group attached to the database"
  type        = string
}
