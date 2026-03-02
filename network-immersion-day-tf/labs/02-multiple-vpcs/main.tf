# Configuração principal do laboratório 02-multiple-vpcs

# VPC A
module "vpc_a" {
  source = "../../modules/vpc"

  name                 = "VPC A"
  cidr_block           = var.vpc_a_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  availability_zones   = var.availability_zones
  tgw_subnet_cidrs     = var.vpc_a_tgw_subnet_cidrs
  tgw_subnet_names     = ["VPC A TGW Subnet AZ1", "VPC A TGW Subnet AZ2"]
  tags                 = var.tags
}

# VPC B
module "vpc_b" {
  source = "../../modules/vpc"

  name                 = "VPC B"
  cidr_block           = var.vpc_b_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  availability_zones   = var.availability_zones
  tgw_subnet_cidrs     = var.vpc_b_tgw_subnet_cidrs
  tgw_subnet_names     = ["VPC B TGW Subnet AZ1", "VPC B TGW Subnet AZ2"]
  tags                 = var.tags
}

# VPC C
module "vpc_c" {
  source = "../../modules/vpc"

  name                 = "VPC C"
  cidr_block           = var.vpc_c_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  availability_zones   = var.availability_zones
  tgw_subnet_cidrs     = var.vpc_c_tgw_subnet_cidrs
  tgw_subnet_names     = ["VPC C TGW Subnet AZ1", "VPC C TGW Subnet AZ2"]
  tags                 = var.tags
}

#Transit Gateway (opcional, caso queira criar um TGW para conectar as VPCs depois)

# ... (código anterior com as VPCs)

# Transit Gateway
module "tgw" {
  source = "../../modules/transit-gateway"

  name                            = var.tgw_name
  description                     = var.tgw_description
  amazon_side_asn                 = var.tgw_amazon_side_asn
  auto_accept_shared_attachments  = var.tgw_auto_accept_shared_attachments
  default_route_table_association = var.tgw_default_route_table_association
  default_route_table_propagation = var.tgw_default_route_table_propagation
  vpn_ecmp_support                = var.tgw_vpn_ecmp_support
  dns_support                     = var.tgw_dns_support
  multicast_support               = var.tgw_multicast_support

  tags = var.tags
}

# Anexos(attachement) VPC ao Transit Gateway
module "tgw_attachment_vpc_a" {
  source = "../../modules/tgw-attachment"

  name               = "VPC A TGW Attachment"
  transit_gateway_id = module.tgw.transit_gateway_id
  vpc_id             = module.vpc_a.vpc_id
  subnet_ids         = module.vpc_a.tgw_subnet_ids
  tags               = var.tags
}

module "tgw_attachment_vpc_b" {
  source = "../../modules/tgw-attachment"

  name               = "VPC B TGW Attachment"
  transit_gateway_id = module.tgw.transit_gateway_id
  vpc_id             = module.vpc_b.vpc_id
  subnet_ids         = module.vpc_b.tgw_subnet_ids
  tags               = var.tags
}
# Attachment da VPC C ao TGW
module "tgw_attachment_vpc_c" {
  source = "../../modules/tgw-attachment"

  name               = "VPC C TGW Attachment"
  transit_gateway_id = module.tgw.transit_gateway_id
  vpc_id             = module.vpc_c.vpc_id
  subnet_ids         = module.vpc_c.tgw_subnet_ids
  tags               = var.tags
}
#subets
# Subnets públicas e privadas para VPC A
module "subnets_a" {
  source = "../../modules/subnets"

  vpc_id               = module.vpc_a.vpc_id
  name_prefix          = "VPC A"
  public_subnet_cidrs  = var.vpc_a_public_subnet_cidrs
  private_subnet_cidrs = var.vpc_a_private_subnet_cidrs
  availability_zones   = var.availability_zones
  tags                 = var.tags
}

# Subnets públicas e privadas para VPC B
module "subnets_b" {
  source = "../../modules/subnets"

  vpc_id               = module.vpc_b.vpc_id
  name_prefix          = "VPC B"
  public_subnet_cidrs  = var.vpc_b_public_subnet_cidrs
  private_subnet_cidrs = var.vpc_b_private_subnet_cidrs
  availability_zones   = var.availability_zones
  tags                 = var.tags
}

# Subnets públicas e privadas para VPC C
module "subnets_c" {
  source = "../../modules/subnets"

  vpc_id               = module.vpc_c.vpc_id
  name_prefix          = "VPC C"
  public_subnet_cidrs  = var.vpc_c_public_subnet_cidrs
  private_subnet_cidrs = var.vpc_c_private_subnet_cidrs
  availability_zones   = var.availability_zones
  tags                 = var.tags
}

# Tabelas de rotas para VPC A
module "route_tables_a" {
  source = "../../modules/route-tables"

  vpc_id                   = module.vpc_a.vpc_id
  public_subnet_ids        = module.subnets_a.public_subnet_ids
  private_subnet_ids       = module.subnets_a.private_subnet_ids
  igw_id                   = null # sem Internet Gateway por enquanto
  nat_gateway_id           = null # sem NAT Gateway
  public_route_table_name  = "VPC A Public Route Table"
  private_route_table_name = "VPC A Private Route Table"
  tags                     = var.tags
}

# Tabelas de rotas para VPC B
module "route_tables_b" {
  source = "../../modules/route-tables"

  vpc_id                   = module.vpc_b.vpc_id
  public_subnet_ids        = module.subnets_b.public_subnet_ids
  private_subnet_ids       = module.subnets_b.private_subnet_ids
  igw_id                   = null
  nat_gateway_id           = null
  public_route_table_name  = "VPC B Public Route Table"
  private_route_table_name = "VPC B Private Route Table"
  tags                     = var.tags
}

# Tabelas de rotas para VPC C
module "route_tables_c" {
  source = "../../modules/route-tables"

  vpc_id                   = module.vpc_c.vpc_id
  public_subnet_ids        = module.subnets_c.public_subnet_ids
  private_subnet_ids       = module.subnets_c.private_subnet_ids
  igw_id                   = null
  nat_gateway_id           = null
  public_route_table_name  = "VPC C Public Route Table"
  private_route_table_name = "VPC C Private Route Table"
  tags                     = var.tags
}
