# =========================================================
# Refactor record: every resource that moved from the flat
# root files into a module. These tell Terraform "same
# resource, new address" so nothing is destroyed.
# =========================================================

# ---------- network (13) ----------
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

# ---------- security (9) ----------
moved {
  from = aws_security_group.alb
  to   = module.security.aws_security_group.alb
}
moved {
  from = aws_security_group.app
  to   = module.security.aws_security_group.app
}
moved {
  from = aws_security_group.db
  to   = module.security.aws_security_group.db
}
moved {
  from = aws_vpc_security_group_ingress_rule.alb_http_from_internet
  to   = module.security.aws_vpc_security_group_ingress_rule.alb_http_from_internet
}
moved {
  from = aws_vpc_security_group_egress_rule.alb_to_app
  to   = module.security.aws_vpc_security_group_egress_rule.alb_to_app
}
moved {
  from = aws_vpc_security_group_ingress_rule.app_from_alb
  to   = module.security.aws_vpc_security_group_ingress_rule.app_from_alb
}
moved {
  from = aws_vpc_security_group_egress_rule.app_https_out
  to   = module.security.aws_vpc_security_group_egress_rule.app_https_out
}
moved {
  from = aws_vpc_security_group_egress_rule.app_to_db
  to   = module.security.aws_vpc_security_group_egress_rule.app_to_db
}
moved {
  from = aws_vpc_security_group_ingress_rule.db_from_app
  to   = module.security.aws_vpc_security_group_ingress_rule.db_from_app
}

# ---------- alb (3) ----------
moved {
  from = aws_lb.main
  to   = module.alb.aws_lb.main
}
moved {
  from = aws_lb_target_group.app
  to   = module.alb.aws_lb_target_group.app
}
moved {
  from = aws_lb_listener.http
  to   = module.alb.aws_lb_listener.http
}

# ---------- database (2) ----------
moved {
  from = aws_db_subnet_group.main
  to   = module.database.aws_db_subnet_group.main
}
moved {
  from = aws_db_instance.main
  to   = module.database.aws_db_instance.main
}

# ---------- compute (6) ----------
moved {
  from = aws_iam_role.app
  to   = module.compute.aws_iam_role.app
}
moved {
  from = aws_iam_role_policy_attachment.app_ssm
  to   = module.compute.aws_iam_role_policy_attachment.app_ssm
}
moved {
  from = aws_iam_instance_profile.app
  to   = module.compute.aws_iam_instance_profile.app
}
moved {
  from = aws_iam_role_policy.app_read_db_secret
  to   = module.compute.aws_iam_role_policy.app_read_db_secret
}
moved {
  from = aws_launch_template.app
  to   = module.compute.aws_launch_template.app
}
moved {
  from = aws_autoscaling_group.app
  to   = module.compute.aws_autoscaling_group.app
}
