variable "env" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the RDS security group"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs for the DB subnet group"
  type        = list(string)
}

variable "ecs_sg_id" {
  description = "Security Group ID of the ECS service to allow ingress"
  type        = string
}

variable "db_instance_class" {
  description = "RDS instance class sizing"
  type        = string
}

variable "backup_retention_period" {
  description = "Number of days to retain automated backups"
  type        = number
}

variable "deletion_protection" {
  description = "Boolean to enable or disable deletion protection"
  type        = bool
}