# modules/database/subnet_group.tf
resource "aws_db_subnet_group" "main" {
  name        = "${var.app_name}-db-subnet-group-${var.environment}"
  description = "Database subnet group for ${var.app_name}"
  subnet_ids  = var.private_subnets

  tags = {
    Name        = "${var.app_name}-db-subnet-group-${var.environment}"
    Environment = var.environment
  }
}
