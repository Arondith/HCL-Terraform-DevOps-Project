mock_provider "aws" {}

run "dev_plan" {
  command = plan

  variables {
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

    enable_nat_gateway = false
    desired_count      = 1
    min_capacity       = 1
    max_capacity       = 2
    log_retention_days = 7
  }

  assert {
    condition     = output.environment == "dev"
    error_message = "Dev plan must preserve the dev environment value."
  }

  assert {
    condition     = output.nat_gateway_enabled == false
    error_message = "Dev plan should use the cost-conscious no-NAT default."
  }

  assert {
    condition     = output.task_network_mode == "public-ip"
    error_message = "Dev tasks should use public IP networking when NAT is disabled."
  }
}

run "prod_plan" {
  command = plan

  variables {
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

    enable_nat_gateway = true
    desired_count      = 2
    min_capacity       = 2
    max_capacity       = 6
    log_retention_days = 30
  }

  assert {
    condition     = output.environment == "prod"
    error_message = "Prod plan must preserve the prod environment value."
  }

  assert {
    condition     = output.nat_gateway_enabled == true
    error_message = "Prod example should create a NAT gateway."
  }

  assert {
    condition     = output.task_network_mode == "private-with-nat"
    error_message = "Prod tasks should use private subnet networking through NAT."
  }
}
