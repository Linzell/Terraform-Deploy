# terraform/modules/ecs/variables.tf

variable "app_name" {
  description = "The name of the application"
  type        = string
}

variable "environment" {
  description = "The deployment environment"
  type        = string
}

variable "frontend_url" {
  description = "The URL of the frontend application"
  type        = string
}

variable "fda_api_key" {
  description = "API key for FDA API"
  type        = string
  sensitive   = true
}

variable "jwt_access_secret" {
  description = "Secret for JWT access tokens"
  type        = string
  sensitive   = true
}

variable "jwt_refresh_secret" {
  description = "Secret for JWT refresh tokens"
  type        = string
  sensitive   = true
}

variable "db_host" {
  description = "Database host"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_port" {
  description = "Database port"
  type        = string
  default     = "5432"
}

variable "db_user" {
  description = "Database user"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "database_url" {
  description = "Complete database connection URL"
  type        = string
  sensitive   = true
}

variable "backend_url" {
  description = "The URL of the backend application"
  type        = string
}

variable "api_url" {
  description = "The URL of the API"
  type        = string
}

# Additional required variables for networking
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "alb_target_group_arn" {
  description = "ARN of the ALB target group"
  type        = string
}

variable "alb_security_group_id" {
  description = "Security group ID of the ALB"
  type        = string
}
