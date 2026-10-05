# --------------- Output values for the created resources -------------

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

output "app_subnet_ids" {
  description = "The IDs of the private app subnets"
  value       = aws_subnet.app[*].id
}

output "db_subnet_ids" {
  description = "The IDs of the private database subnets"
  value       = aws_subnet.db[*].id
}

output "nat_gateway_public_ip" {
  description = "Public IP used by private subnets for outbound internet"
  value       = aws_eip.nat.public_ip
}