resource "aws_db_instance" "main" {
  identifier        = "${var.app_name}-db-${var.environment}"
  engine           = "postgres"
  engine_version   = "13.7"
  instance_class   = "db.t2.micro"

  allocated_storage    = 20
  storage_type        = "gp2"

  db_name     = var.database_name
  username    = var.database_username
  password    = var.database_password

  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name

  skip_final_snapshot = true

  # Add parameter group settings
  parameter_group_name = aws_db_parameter_group.main.name

  # Add backup settings
  backup_retention_period = 7
  backup_window          = "03:00-04:00"
  maintenance_window     = "Mon:04:00-Mon:05:00"

  # Enable deletion protection in production
  deletion_protection = var.environment == "production" ? true : false

  tags = {
    Name        = "${var.app_name}-db-${var.environment}"
    Environment = var.environment
  }
}

# Add a parameter group
resource "aws_db_parameter_group" "main" {
  name_prefix = "${var.app_name}-pg-${var.environment}"
  family      = "postgres13"

  parameter {
    name  = "log_connections"
    value = "1"
  }

  parameter {
    name  = "log_disconnections"
    value = "1"
  }

  tags = {
    Name        = "${var.app_name}-pg-${var.environment}"
    Environment = var.environment
  }

  lifecycle {
    create_before_destroy = true
  }
}
