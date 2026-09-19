variable "name" {
  description = "Name prefix for ECS resources."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID."
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for the load balancer."
  type        = list(string)
}

variable "task_subnet_ids" {
  description = "Subnet IDs where ECS tasks run."
  type        = list(string)
}

variable "assign_public_ip" {
  description = "Whether ECS tasks receive public IP addresses."
  type        = bool
  default     = false
}

variable "container_image" {
  description = "Container image to deploy."
  type        = string
  default     = "nginx:1.27-alpine"
}

variable "container_port" {
  description = "Container port exposed through the load balancer."
  type        = number
  default     = 80

  validation {
    condition     = var.container_port >= 1 && var.container_port <= 65535
    error_message = "container_port must be between 1 and 65535."
  }
}

variable "cpu" {
  description = "Fargate task CPU units."
  type        = number
  default     = 256
}

variable "memory" {
  description = "Fargate task memory in MiB."
  type        = number
  default     = 512
}

variable "desired_count" {
  description = "Desired ECS service task count."
  type        = number
  default     = 1

  validation {
    condition     = var.desired_count >= 1
    error_message = "desired_count must be at least 1."
  }
}

variable "min_capacity" {
  description = "Minimum autoscaling capacity."
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Maximum autoscaling capacity."
  type        = number
  default     = 4
}

variable "log_retention_days" {
  description = "CloudWatch Logs retention period."
  type        = number
  default     = 30
}

variable "tags" {
  description = "Additional tags."
  type        = map(string)
  default     = {}
}
