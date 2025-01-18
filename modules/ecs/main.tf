# modules/ecs/main.tf
resource "aws_ecs_cluster" "main" {
  name = "${var.app_name}-cluster-${var.environment}"
}

resource "aws_ecs_task_definition" "backend" {
  family                   = "${var.app_name}-backend"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                     = 256
  memory                  = 512

  container_definitions = jsonencode([
    {
      name  = "backend"
      image = "${aws_ecr_repository.backend.repository_url}:latest"

      environment = [
        {
          name  = "FRONTEND_URL"
          value = var.frontend_url
        },
        {
          name  = "FDA_API_KEY"
          value = var.fda_api_key
        },
        {
          name  = "JWT_ACCESS_SECRET"
          value = var.jwt_access_secret
        },
        {
          name  = "JWT_REFRESH_SECRET"
          value = var.jwt_refresh_secret
        },
        {
          name  = "PORT"
          value = "3000"
        },
        {
          name  = "DB_HOST"
          value = var.db_host
        },
        {
          name  = "DB_NAME"
          value = var.db_name
        },
        {
          name  = "DB_PORT"
          value = var.db_port
        },
        {
          name  = "DB_USER"
          value = var.db_user
        },
        {
          name  = "DB_PASSWORD"
          value = var.db_password
        },
        {
          name  = "DB_POOL_SIZE"
          value = "20"
        },
        {
          name  = "DATABASE_URL"
          value = var.database_url
        }
      ]

      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    }
  ])
}

resource "aws_ecs_task_definition" "frontend" {
  family                   = "${var.app_name}-frontend"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                     = 256
  memory                  = 512

  container_definitions = jsonencode([
    {
      name  = "frontend"
      image = "${aws_ecr_repository.frontend.repository_url}:latest"

      environment = [
        {
          name  = "VITE_BACKEND_URL"
          value = var.backend_url
        },
        {
          name  = "API_URL"
          value = var.api_url
        },
        {
          name  = "JWT_ACCESS_SECRET"
          value = var.jwt_access_secret
        },
        {
          name = "JWT_REFRESH_SECRET"
          value = var.jwt_refresh_secret
        }
      ]

      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    }
  ])
}
