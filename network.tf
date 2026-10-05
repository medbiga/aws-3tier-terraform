# Ask AWS which AZs are available in this region, instead of hardcoding names

# data is used to retrieve information about existing resources. In this case, we are using the aws_availability_zones data source to get a list of available availability zones in the specified AWS region.
data "aws_availability_zones" "available" {
  state = "available"
}
# lacals are used to store values that can be reused throughout the configuration. In this case, we are using locals to store the availability zones and a name prefix for resource naming.
locals {
  # Use the first two available AZs for our subnets
  azs         = slice(data.aws_availability_zones.available.names, 0, 2) # here we are using the slice function to get the first two availability zones from the list of available AZs. This allows us to create subnets in different AZs for high availability.
  name_prefix = "${var.project_name}-${var.environment}"                 # here we are creating a name prefix for our resources based on the project name and environment. This helps to keep resource names organized and easily identifiable.
}

# ------------- create VPC -------------

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${local.name_prefix}-vpc"
  }
}

# ------------- create public subnets (web tier) -------------

resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = local.azs[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${local.name_prefix}-public-subnet-${local.azs[count.index]}"
    tier = "public"
  }
}

#------------- create private subnets (app tier EC2) -------------

resource "aws_subnet" "app" {
  count             = length(var.app_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.app_subnet_cidrs[count.index]
  availability_zone = local.azs[count.index]
  tags = {
    Name = "${local.name_prefix}-app-subnet-${local.azs[count.index]}"
    tier = "app"
  }
}

#------------ create private subnets (database tier RDS) -------------

resource "aws_subnet" "db" {
  count             = length(var.db_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.db_subnet_cidrs[count.index]
  availability_zone = local.azs[count.index]
  tags = {
    Name = "${local.name_prefix}-db-subnet-${local.azs[count.index]}"
    tier = "db"
  }
}

# ---------- Internet Gateway (front door) ----------
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${local.name_prefix}-igw"
  }
}

# ---------- Elastic IP for the NAT Gateway ----------
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${local.name_prefix}-nat-eip"
  }
}

# ---------- NAT Gateway (outbound-only exit for private subnets) ----------
# Single NAT for cost savings in dev. Production: one per AZ.
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "${local.name_prefix}-nat"
  }

  depends_on = [aws_internet_gateway.main]
}

# ---------- Public route table: internet via IGW ----------
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${local.name_prefix}-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# ---------- App route table: outbound internet via NAT ----------
resource "aws_route_table" "app" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name = "${local.name_prefix}-app-rt"
  }
}

resource "aws_route_table_association" "app" {
  count          = length(aws_subnet.app)
  subnet_id      = aws_subnet.app[count.index].id
  route_table_id = aws_route_table.app.id
}

# ---------- DB route table: NO internet route (VPC-local only) ----------
resource "aws_route_table" "db" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${local.name_prefix}-db-rt"
  }
}

resource "aws_route_table_association" "db" {
  count          = length(aws_subnet.db)
  subnet_id      = aws_subnet.db[count.index].id
  route_table_id = aws_route_table.db.id
}