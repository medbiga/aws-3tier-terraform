output "target_group_arn" {
  description = "ARN of the app target group (the ASG registers servers here)"
  value       = aws_lb_target_group.app.arn
}

output "alb_dns_name" {
  description = "Public DNS name of the load balancer"
  value       = aws_lb.main.dns_name
}
