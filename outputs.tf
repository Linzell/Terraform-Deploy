# outputs.tf
# VPC Outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.networking.vpc_id
}

output "private_subnets" {
  description = "List of private subnet IDs"
  value       = module.networking.private_subnets
}

output "public_subnets" {
  description = "List of public subnet IDs"
  value       = module.networking.public_subnets
}

# Database Outputs
output "database_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = module.database.endpoint
}

output "database_name" {
  description = "The name of the database"
  value       = module.database.database_name
}

output "database_url" {
  description = "The database connection URL"
  value       = module.database.database_url
  sensitive   = true
}

# ECS Outputs
output "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  value       = module.ecs.cluster_name
}

output "ecs_cluster_arn" {
  description = "The ARN of the ECS cluster"
  value       = module.ecs.cluster_arn
}

output "backend_service_name" {
  description = "The name of the backend ECS service"
  value       = module.ecs.backend_service_name
}

output "frontend_service_name" {
  description = "The name of the frontend ECS service"
  value       = module.ecs.frontend_service_name
}

# Load Balancer Outputs
output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = module.alb.dns_name
}

output "alb_zone_id" {
  description = "The zone ID of the load balancer"
  value       = module.alb.zone_id
}

output "backend_target_group_arn" {
  description = "The ARN of the backend target group"
  value       = module.alb.backend_target_group_arn
}

output "frontend_target_group_arn" {
  description = "The ARN of the frontend target group"
  value       = module.alb.frontend_target_group_arn
}

# Security Groups Outputs
output "alb_security_group_id" {
  description = "The ID of the ALB security group"
  value       = module.alb.security_group_id
}

output "ecs_security_group_id" {
  description = "The ID of the ECS security group"
  value       = module.ecs.security_group_id
}

output "database_security_group_id" {
  description = "The ID of the database security group"
  value       = module.database.security_group_id
}

# ECR Repository Outputs
output "backend_repository_url" {
  description = "The URL of the backend ECR repository"
  value       = module.ecs.backend_repository_url
}

output "frontend_repository_url" {
  description = "The URL of the frontend ECR repository"
  value       = module.ecs.frontend_repository_url
}

# CloudWatch Outputs
output "log_group_name" {
  description = "The name of the CloudWatch log group"
  value       = module.ecs.log_group_name
}

# Route53 Outputs (if you're using Route53 for DNS)
output "domain_name" {
  description = "The domain name for the application"
  value       = var.domain_name
}

# Additional Operational Outputs
output "environment" {
  description = "The environment name"
  value       = var.environment
}

output "region" {
  description = "The AWS region"
  value       = var.aws_region
}
