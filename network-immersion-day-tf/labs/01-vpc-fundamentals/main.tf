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
