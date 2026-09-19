project_name       = "cloudforge"
environment        = "prod"
aws_region         = "us-east-1"
availability_zones = ["us-east-1a", "us-east-1b"]

vpc_cidr = "10.20.0.0/16"

public_subnet_cidrs = [
  "10.20.0.0/24",
  "10.20.1.0/24"
]

private_subnet_cidrs = [
  "10.20.10.0/24",
  "10.20.11.0/24"
]

# Production example: private ECS tasks egress through NAT.
enable_nat_gateway = true

desired_count      = 2
min_capacity       = 2
max_capacity       = 6
log_retention_days = 30

extra_tags = {
  CostCenter = "production-example"
}
