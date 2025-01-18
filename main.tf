# main.tf
module "networking" {
  source = "./modules/networking"
  environment = var.environment
  app_name    = var.app_name
}

module "database" {
  source = "./modules/database"

  vpc_id                = module.networking.vpc_id
  private_subnets       = module.networking.private_subnets
  environment           = var.environment
  app_name             = var.app_name
  database_name        = var.database_name
  database_username    = var.database_username
  database_password    = var.database_password
  app_security_group_id = module.ecs.security_group_id
}

module "ecs" {
  source = "./modules/ecs"

  vpc_id          = module.networking.vpc_id
  public_subnets  = module.networking.public_subnets
  private_subnets = module.networking.private_subnets
  environment     = var.environment
  app_name        = var.app_name

  frontend_url       = var.frontend_url
  backend_url        = var.backend_url
  api_url           = var.api_url
  fda_api_key       = var.fda_api_key
  jwt_access_secret = var.jwt_access_secret
  jwt_refresh_secret = var.jwt_refresh_secret

  db_host     = module.database.endpoint
  db_name     = var.database_name
  db_user     = var.database_username
  db_password = var.database_password
  database_url = module.database.database_url

  alb_target_group_arn = module.alb.target_group_arn
  alb_security_group_id = module.alb.security_group_id
}

module "alb" {
  source = "./modules/alb"

  app_name        = var.app_name
  environment     = var.environment
  vpc_id          = module.networking.vpc_id
  public_subnets  = module.networking.public_subnets
  certificate_arn = var.certificate_arn
}
