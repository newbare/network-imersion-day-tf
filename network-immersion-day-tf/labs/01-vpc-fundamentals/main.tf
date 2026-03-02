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

  vpc_id                   = module.vpc.vpc_id
  public_subnet_ids        = module.subnets.public_subnet_ids
  private_subnet_ids       = module.subnets.private_subnet_ids
  igw_id                   = module.igw.igw_id
  nat_gateway_id           = module.nat_gateway.nat_gateway_id
  public_route_table_name  = "VPC A Public Route Table"
  private_route_table_name = "VPC A Private Route Table"
  tags                     = var.tags
}

# ... (código anterior com módulos vpc, subnets, network_acl, igw, nat_gateway, route_tables)

# Módulo Security Groups
module "security_groups" {
  source = "../../modules/security-groups"

  vpc_id               = module.vpc.vpc_id
  my_ip_cidr           = var.my_ip_cidr
  private_subnet_cidrs = var.private_subnet_cidrs # <-- nova linha
  public_sg_name       = "VPC A Security Group Public"
  private_sg_name      = "VPC A Security Group Private"
  tags                 = var.tags
}

# Módulo VPC Endpoints (Gateway para S3 e Interface para KMS)
module "vpc_endpoints" {
  source = "../../modules/vpc-endpoints"

  vpc_id             = module.vpc.vpc_id
  region             = var.region
  private_subnet_ids = module.subnets.private_subnet_ids
  security_group_ids = [module.security_groups.kms_endpoint_sg_id]
  route_table_ids = concat(
    [module.route_tables.public_route_table_id],
    [module.route_tables.private_route_table_id]
  )
  enable_private_dns      = true
  create_legacy_endpoints = var.create_legacy_endpoints # <-- ativa os endpoints fixos

  tags = var.tags
}

# ... (código anterior até módulo vpc_endpoints) ...

# Módulo IAM Roles
module "iam_roles" {
  source = "../../modules/iam-roles"

  role_name             = "NetworkingWorkshopInstanceRole-${var.environment}"
  instance_profile_name = "NetworkingWorkshopInstanceProfile-${var.environment}"
  tags                  = var.tags
}

# Data source da AMI Amazon Linux 2023
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

# Instância pública (AZ2)
module "ec2_public" {
  source = "../../modules/ec2-instance"

  name                   = "VPC A Public AZ2 Server"
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  subnet_id              = module.subnets.public_subnet_ids[1] # AZ2
  private_ip             = "10.0.2.100"
  vpc_security_group_ids = [module.security_groups.public_sg_id]
  iam_instance_profile   = module.iam_roles.instance_profile_name
  associate_public_ip    = true
  user_data              = file("${path.module}/user_data.sh")
  tags                   = var.tags
}

# Instância privada (AZ1)
module "ec2_private" {
  source = "../../modules/ec2-instance"

  name                   = "VPC A Private AZ1 Server"
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  subnet_id              = module.subnets.private_subnet_ids[0] # AZ1
  private_ip             = "10.0.1.100"
  vpc_security_group_ids = [module.security_groups.private_sg_id]
  iam_instance_profile   = module.iam_roles.instance_profile_name
  associate_public_ip    = false
  user_data              = file("${path.module}/user_data.sh")
  tags                   = var.tags
}
