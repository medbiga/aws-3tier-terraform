output "db_endpoint" {
  description = "Hostname of the RDS database"
  value       = aws_db_instance.main.address
}

output "db_secret_arn" {
  description = "ARN of the Secrets Manager secret holding the DB credentials"
  value       = aws_db_instance.main.master_user_secret[0].secret_arn
}
