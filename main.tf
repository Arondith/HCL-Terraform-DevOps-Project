locals {
  name = "${var.project_name}-${var.environment}"

  task_subnet_ids = var.enable_nat_gateway ? module.network.private_subnet_ids : module.network.public_subnet_ids

  common_tags = merge(
    {
      Application = "CloudForge"
      Owner       = "Portfolio"
    },
    var.extra_tags
  )
}

module "network" {
  source = "./modules/network"

  name                 = local.name
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  enable_nat_gateway   = var.enable_nat_gateway
  tags                 = local.common_tags
}

module "ecs_service" {
  source = "./modules/ecs_service"

  name                = local.name
  vpc_id              = module.network.vpc_id
  public_subnet_ids   = module.network.public_subnet_ids
  task_subnet_ids     = local.task_subnet_ids
  assign_public_ip    = !var.enable_nat_gateway
  container_image     = var.container_image
  desired_count       = var.desired_count
  min_capacity        = var.min_capacity
  max_capacity        = var.max_capacity
  log_retention_days  = var.log_retention_days
  tags                = local.common_tags
}
