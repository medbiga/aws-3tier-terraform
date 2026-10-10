output "vpc_id" {
  description = "ID of the VPC"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.network.public_subnet_ids
}

output "app_subnet_ids" {
  description = "IDs of the private app subnets"
  value       = module.network.app_subnet_ids
}

output "db_subnet_ids" {
  description = "IDs of the private DB subnets"
  value       = module.network.db_subnet_ids
}

output "nat_gateway_public_ip" {
  description = "Public IP used by private subnets for outbound internet"
  value       = module.network.nat_public_ip
}

output "alb_url" {
  description = "Public URL of the application"
  value       = "http://${module.alb.alb_dns_name}"
}

output "db_endpoint" {
  description = "Hostname of the RDS database"
  value       = module.database.db_endpoint
}

output "db_secret_arn" {
  description = "ARN of the Secrets Manager secret holding the DB credentials"
  value       = module.database.db_secret_arn
}
