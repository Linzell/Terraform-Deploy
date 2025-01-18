# variables.tf
variable "aws_region" {
  description = "AWS region"
  default     = "eu-west-3"  # Paris region
}

variable "environment" {
  description = "Environment name"
  default     = "production"
}

variable "database_name" {
  description = "Name of the database"
}

variable "database_username" {
  description = "Database username"
}

variable "database_password" {
  description = "Database password"
}

variable "app_name" {
  description = "Application name"
  default     = "medications-app"
}

variable "domain_name" {
  description = "Domain name for the application"
  type        = string
}

variable "certificate_arn" {
  description = "ARN of the SSL certificate"
  type        = string
}

variable "frontend_url" {
  description = "The URL of the frontend application"
  type        = string
}

variable "fda_api_key" {
  description = "API key for FDA API"
  type        = string
}

variable "jwt_access_secret" {
  description = "Secret for JWT access tokens"
  type        = string
}

variable "jwt_refresh_secret" {
  description = "Secret for JWT refresh tokens"
  type        = string
}

variable "backend_url" {
  description = "The URL of the backend application"
  type        = string
}

variable "api_url" {
  description = "The URL of the API"
  type        = string
}
