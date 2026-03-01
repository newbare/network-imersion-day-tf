# Configuração principal do laboratório 01-vpc-fundamentals

# labs/01-vpc-fundamentals/main.tf


# Módulo VPC
module "vpc" {
  source = "../../modules/vpc"

  name       = var.vpc_name
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = var.tags
}
