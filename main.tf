locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

module "network" {
  source = "./modules/network"

  name_prefix         = local.name_prefix
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  app_subnet_cidrs    = var.app_subnet_cidrs
  db_subnet_cidrs     = var.db_subnet_cidrs
}

# ---------- Refactor: resources moved into the network module ----------
moved {
  from = aws_vpc.main
  to   = module.network.aws_vpc.main
}
moved {
  from = aws_subnet.public
  to   = module.network.aws_subnet.public
}
moved {
  from = aws_subnet.app
  to   = module.network.aws_subnet.app
}
moved {
  from = aws_subnet.db
  to   = module.network.aws_subnet.db
}
moved {
  from = aws_internet_gateway.main
  to   = module.network.aws_internet_gateway.main
}
moved {
  from = aws_eip.nat
  to   = module.network.aws_eip.nat
}
moved {
  from = aws_nat_gateway.main
  to   = module.network.aws_nat_gateway.main
}
moved {
  from = aws_route_table.public
  to   = module.network.aws_route_table.public
}
moved {
  from = aws_route_table.app
  to   = module.network.aws_route_table.app
}
moved {
  from = aws_route_table.db
  to   = module.network.aws_route_table.db
}
moved {
  from = aws_route_table_association.public
  to   = module.network.aws_route_table_association.public
}
moved {
  from = aws_route_table_association.app
  to   = module.network.aws_route_table_association.app
}
moved {
  from = aws_route_table_association.db
  to   = module.network.aws_route_table_association.db
}