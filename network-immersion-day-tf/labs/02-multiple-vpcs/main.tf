# Configuração principal do laboratório 02-multiple-vpcs

# VPC A
module "vpc_a" {
  source = "../../modules/vpc"

  name             = "VPC A"
  cidr_block       = var.vpc_a_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  availability_zones   = var.availability_zones
  tgw_subnet_cidrs     = var.vpc_a_tgw_subnet_cidrs
  tgw_subnet_names     = ["VPC A TGW Subnet AZ1", "VPC A TGW Subnet AZ2"]
  tags = var.tags
}

# VPC B
module "vpc_b" {
  source = "../../modules/vpc"

  name             = "VPC B"
  cidr_block       = var.vpc_b_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  availability_zones   = var.availability_zones
  tgw_subnet_cidrs     = var.vpc_b_tgw_subnet_cidrs
  tgw_subnet_names     = ["VPC B TGW Subnet AZ1", "VPC B TGW Subnet AZ2"]
  tags = var.tags
}

# VPC C
module "vpc_c" {
  source = "../../modules/vpc"

  name             = "VPC C"
  cidr_block       = var.vpc_c_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  availability_zones   = var.availability_zones
  tgw_subnet_cidrs     = var.vpc_c_tgw_subnet_cidrs
  tgw_subnet_names     = ["VPC C TGW Subnet AZ1", "VPC C TGW Subnet AZ2"]
  tags = var.tags
}
