# =========================================================
# Root module: wires the five modules together.
# Values flow between modules ONLY through this file.
# =========================================================

locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

# ---------- Network: VPC, subnets, gateways, routing ----------
module "network" {
  source = "./modules/network"

  name_prefix         = local.name_prefix
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  app_subnet_cidrs    = var.app_subnet_cidrs
  db_subnet_cidrs     = var.db_subnet_cidrs
}

# ---------- Security: security groups chained by reference ----------
module "security" {
  source = "./modules/security"

  name_prefix = local.name_prefix
  vpc_id      = module.network.vpc_id
  app_port    = var.app_port
  db_port     = var.db_port
}

# ---------- Web tier: Application Load Balancer ----------
module "alb" {
  source = "./modules/alb"

  name_prefix       = local.name_prefix
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids
  alb_sg_id         = module.security.alb_sg_id
  app_port          = var.app_port
}

# ---------- Data tier: RDS MySQL ----------
module "database" {
  source = "./modules/database"

  name_prefix   = local.name_prefix
  db_subnet_ids = module.network.db_subnet_ids
  db_sg_id      = module.security.db_sg_id
}

# ---------- App tier: launch template, ASG, instance role ----------
module "compute" {
  source = "./modules/compute"

  name_prefix          = local.name_prefix
  app_subnet_ids       = module.network.app_subnet_ids
  app_sg_id            = module.security.app_sg_id
  target_group_arn     = module.alb.target_group_arn
  db_secret_arn        = module.database.db_secret_arn
  instance_type        = var.instance_type
  asg_min_size         = var.asg_min_size
  asg_max_size         = var.asg_max_size
  asg_desired_capacity = var.asg_desired_capacity
}
