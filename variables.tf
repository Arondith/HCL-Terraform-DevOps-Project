variable "project_name" {
  description = "Project name used in resource naming."
  type        = string
  default     = "cloudforge"

  validation {
    condition     = can(regex("^[a-z0-9-]{2,20}$", var.project_name))
    error_message = "project_name must be 2-20 lowercase letters, numbers, or hyphens."
  }
}

variable "environment" {
  description = "Deployment environment."
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be dev, staging, or prod."
  }
}

variable "aws_region" {
  description = "AWS region."
  type        = string
  default     = "us-east-1"
}

variable "availability_zones" {
  description = "Availability zones for the environment."
  type        = list(string)
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets."
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets."
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Use a NAT gateway for private ECS task egress."
  type        = bool
  default     = false
}

variable "container_image" {
  description = "Container image deployed by ECS."
  type        = string
  default     = "nginx:1.27-alpine"
}

variable "desired_count" {
  description = "Desired ECS task count."
  type        = number
  default     = 1
}

variable "min_capacity" {
  description = "Minimum ECS autoscaling capacity."
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Maximum ECS autoscaling capacity."
  type        = number
  default     = 3
}

variable "log_retention_days" {
  description = "CloudWatch log retention."
  type        = number
  default     = 14
}

variable "extra_tags" {
  description = "Extra tags applied to resources."
  type        = map(string)
  default     = {}
}
