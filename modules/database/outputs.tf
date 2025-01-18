output "endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = aws_db_instance.main.endpoint
}

output "database_name" {
  description = "The name of the database"
  value       = aws_db_instance.main.db_name
}

output "database_url" {
  description = "The database connection URL"
  value       = "postgresql://${aws_db_instance.main.username}:${aws_db_instance.main.password}@${aws_db_instance.main.endpoint}/${aws_db_instance.main.db_name}"
  sensitive   = true
}

output "security_group_id" {
  description = "The ID of the database security group"
  value       = aws_security_group.rds.id
}

output "parameter_group_name" {
  description = "The name of the database parameter group"
  value       = aws_db_parameter_group.main.name
}

output "instance_id" {
  description = "The ID of the RDS instance"
  value       = aws_db_instance.main.id
}
