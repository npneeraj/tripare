variable "env" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where ECS resources will be deployed"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet IDs for ALB (if public)"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet IDs for Fargate tasks"
  type        = list(string)
}

variable "task_cpu" {
  description = "CPU units for the Fargate task"
  type        = number
}

variable "task_memory" {
  description = "Memory for the Fargate task"
  type        = number
}