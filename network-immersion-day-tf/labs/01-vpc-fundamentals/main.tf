# Configuração principal do laboratório 01-vpc-fundamentals

# labs/01-vpc-fundamentals/main.tf


# Módulo VPC
module "vpc" {
  source = "../../modules/vpc"

  name                 = var.vpc_name
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = var.tags
}

# Módulo Subnets
module "subnets" {
  source = "../../modules/subnets"

  vpc_id               = module.vpc.vpc_id
  name_prefix          = var.vpc_name
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  tags                 = var.tags
}
# ... (código anterior com módulos vpc e subnets)

# Módulo Network ACL
module "network_acl" {
  source = "../../modules/network-acl"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = concat(module.subnets.public_subnet_ids, module.subnets.private_subnet_ids)
  name       = "VPC A Workload Subnets NACL"
  tags       = var.tags

  # As regras padrão já permitem todo tráfego (conforme tutorial)
  # Se quiser ser explícito, pode passar as regras abaixo (idênticas ao default)
  # inbound_rules = [
  #   {
  #     rule_no    = 100
  #     protocol   = "-1"
  #     action     = "allow"
  #     cidr_block = "0.0.0.0/0"
  #     from_port  = 0
  #     to_port    = 0
  #   }
  # ]
  # outbound_rules = [
  #   {
  #     rule_no    = 100
  #     protocol   = "-1"
  #     action     = "allow"
  #     cidr_block = "0.0.0.0/0"
  #     from_port  = 0
  #     to_port    = 0
  #   }
  # ]
}


# Módulo Internet Gateway - este módulo deve ser criado antes de route-tables, pois a rota para o IGW precisa do ID do IGW
# No tutorial, o IGW é criado depois das route tables, mas isso é apenas para mostrar que a rota pode ser criada mesmo antes do IGW existir. Na prática, é mais comum criar o IGW primeiro.
module "igw" {
  source = "../../modules/internet-gateway"

  vpc_id = module.vpc.vpc_id
  name   = "VPC A IGW"
  tags   = var.tags
}

# Módulo NAT Gateway (na primeira subnet pública)
module "nat_gateway" {
  source = "../../modules/nat-gateway"

  name      = "VPC A NATGW"
  subnet_id = module.subnets.public_subnet_ids[0] # AZ1
  tags      = var.tags
}

# As rotas (pública e privada) serão adicionadas depois, em um módulo separado ou via aws_route

# Módulo Route Tables (com rotas para IGW e NAT)
module "route_tables" {
  source = "../../modules/route-tables"

  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.subnets.public_subnet_ids
  private_subnet_ids  = module.subnets.private_subnet_ids
  igw_id              = module.igw.igw_id
  nat_gateway_id      = module.nat_gateway.nat_gateway_id
  public_route_table_name  = "VPC A Public Route Table"
  private_route_table_name = "VPC A Private Route Table"
  tags                = var.tags
}