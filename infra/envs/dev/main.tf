provider "aws" {
  region = "us-east-1"
}

module "network" {
  source   = "../../modules/network"
  env      = "dev"
  vpc_cidr = "10.0.0.0/16"
}

module "ecs" {
  source          = "../../modules/ecs"
  env             = "dev"
  vpc_id          = module.network.vpc_id
  public_subnets  = module.network.public_subnets
  private_subnets = module.network.private_subnets
  task_cpu        = var.task_cpu
  task_memory     = var.task_memory
}

module "rds" {
  source                  = "../../modules/rds"
  env                     = "dev"
  vpc_id                  = module.network.vpc_id
  private_subnets         = module.network.private_subnets
  ecs_sg_id               = module.ecs.ecs_sg_id
  db_instance_class       = var.db_instance_class
  backup_retention_period = var.backup_retention_period
  deletion_protection     = var.deletion_protection
}