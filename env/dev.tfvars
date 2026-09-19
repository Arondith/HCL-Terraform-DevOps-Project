project_name       = "cloudforge"
environment        = "dev"
aws_region         = "us-east-1"
availability_zones = ["us-east-1a", "us-east-1b"]

vpc_cidr = "10.10.0.0/16"

public_subnet_cidrs = [
  "10.10.0.0/24",
  "10.10.1.0/24"
]

private_subnet_cidrs = [
  "10.10.10.0/24",
  "10.10.11.0/24"
]

# Cost-conscious portfolio default: ECS tasks use public subnets with assigned
# public IPs. Set this to true for private task networking through a NAT gateway.
enable_nat_gateway = false

desired_count      = 1
min_capacity       = 1
max_capacity       = 2
log_retention_days = 7

extra_tags = {
  CostCenter = "portfolio"
}
