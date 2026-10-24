variable "task_cpu" {
  description = "CPU units for the Fargate task"
  type        = number
}

variable "task_memory" {
  description = "Memory for the Fargate task"
  type        = number
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