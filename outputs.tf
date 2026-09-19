output "environment" {
  description = "Environment name."
  value       = var.environment
}

output "vpc_id" {
  description = "VPC ID."
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs."
  value       = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs."
  value       = module.network.private_subnet_ids
}

output "ecs_cluster_name" {
  description = "ECS cluster name."
  value       = module.ecs_service.cluster_name
}

output "ecs_service_name" {
  description = "ECS service name."
  value       = module.ecs_service.service_name
}

output "application_url" {
  description = "HTTP URL of the application load balancer."
  value       = "http://${module.ecs_service.load_balancer_dns_name}"
}

output "task_network_mode" {
  description = "How ECS tasks receive outbound network access."
  value       = var.enable_nat_gateway ? "private-with-nat" : "public-ip"
}

output "nat_gateway_enabled" {
  description = "Whether the environment creates a NAT gateway."
  value       = module.network.nat_gateway_enabled
}
