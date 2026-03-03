# Configuração principal do laboratório 03-security-controls

# ======================================================================
# INFRAESTRUTURA BASE DO LABORATÓRIO 03 - SECURITY CONTROLS
# ======================================================================

# ----------------------------------------------------------------------
# VPC A
# ----------------------------------------------------------------------
module "vpc_a" {
  source = "../../modules/vpc"

  name                 = "VPC A"
  cidr_block           = var.vpc_a_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = var.tags
}

# Subnets da VPC A
module "subnets_a" {
  source = "../../modules/subnets"

  vpc_id               = module.vpc_a.vpc_id
  name_prefix          = "VPC A"
  public_subnet_cidrs  = var.vpc_a_public_subnet_cidrs
  private_subnet_cidrs = var.vpc_a_private_subnet_cidrs
  availability_zones   = var.availability_zones
  tags                 = var.tags
}

# Subnets TGW da VPC A (criadas manualmente porque o módulo vpc já as cria? No módulo vpc atual, ele cria subnets TGW se tgw_subnet_cidrs for passado. Vamos usar essa funcionalidade.)
# Mas o módulo vpc que você mostrou não tem saída para os IDs das subnets TGW. Vamos precisar ajustar o módulo vpc para exportar esses IDs.
# Como isso pode ser uma mudança em módulo existente, vamos verificar. No módulo vpc atual, ele cria subnets TGW com resource "aws_subnet" "tgw" e não exporta os IDs. Precisamos adicionar uma output no módulo vpc.
# Por enquanto, vou considerar que o módulo vpc tem uma output chamada "tgw_subnet_ids". Se não tiver, teremos que criar as subnets TGW manualmente aqui no main.tf.

# Para não quebrar a modularidade, sugiro ajustarmos o módulo vpc para exportar tgw_subnet_ids. Mas como combinamos que módulos existentes podem ser ajustados? Acho melhor criar as subnets TGW diretamente no main.tf para não modificar módulos antigos. Vamos seguir essa abordagem para manter o lab 3 independente.

# Subnets TGW da VPC A (criação direta)
resource "aws_subnet" "vpc_a_tgw_az1" {
  vpc_id            = module.vpc_a.vpc_id
  cidr_block        = var.vpc_a_tgw_subnet_cidrs[0]
  availability_zone = var.availability_zones[0]

  tags = merge(var.tags, {
    Name = "VPC A TGW Subnet AZ1"
  })
}

resource "aws_subnet" "vpc_a_tgw_az2" {
  vpc_id            = module.vpc_a.vpc_id
  cidr_block        = var.vpc_a_tgw_subnet_cidrs[1]
  availability_zone = var.availability_zones[1]

  tags = merge(var.tags, {
    Name = "VPC A TGW Subnet AZ2"
  })
}

# Internet Gateway da VPC A
module "igw_a" {
  source = "../../modules/internet-gateway"

  vpc_id = module.vpc_a.vpc_id
  name   = "VPC A IGW"
  tags   = var.tags
}

# NAT Gateway da VPC A (na primeira subnet pública)
module "nat_a" {
  source = "../../modules/nat-gateway"

  name      = "VPC A NATGW"
  subnet_id = module.subnets_a.public_subnet_ids[0]
  tags      = var.tags
}

# Tabelas de rotas da VPC A
module "route_tables_a" {
  source = "../../modules/route-tables"

  vpc_id                   = module.vpc_a.vpc_id
  public_subnet_ids        = module.subnets_a.public_subnet_ids
  private_subnet_ids       = module.subnets_a.private_subnet_ids
  igw_id                   = module.igw_a.igw_id
  nat_gateway_id           = module.nat_a.nat_gateway_id
  public_route_table_name  = "VPC A Public Route Table"
  private_route_table_name = "VPC A Private Route Table"
  tags                     = var.tags
}

# ----------------------------------------------------------------------
# VPC B
# ----------------------------------------------------------------------
module "vpc_b" {
  source = "../../modules/vpc"

  name                 = "VPC B"
  cidr_block           = var.vpc_b_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = var.tags
}

module "subnets_b" {
  source = "../../modules/subnets"

  vpc_id               = module.vpc_b.vpc_id
  name_prefix          = "VPC B"
  public_subnet_cidrs  = var.vpc_b_public_subnet_cidrs
  private_subnet_cidrs = var.vpc_b_private_subnet_cidrs
  availability_zones   = var.availability_zones
  tags                 = var.tags
}

# Subnets TGW da VPC B
resource "aws_subnet" "vpc_b_tgw_az1" {
  vpc_id            = module.vpc_b.vpc_id
  cidr_block        = var.vpc_b_tgw_subnet_cidrs[0]
  availability_zone = var.availability_zones[0]

  tags = merge(var.tags, {
    Name = "VPC B TGW Subnet AZ1"
  })
}

resource "aws_subnet" "vpc_b_tgw_az2" {
  vpc_id            = module.vpc_b.vpc_id
  cidr_block        = var.vpc_b_tgw_subnet_cidrs[1]
  availability_zone = var.availability_zones[1]

  tags = merge(var.tags, {
    Name = "VPC B TGW Subnet AZ2"
  })
}

module "igw_b" {
  source = "../../modules/internet-gateway"

  vpc_id = module.vpc_b.vpc_id
  name   = "VPC B IGW"
  tags   = var.tags
}

module "nat_b" {
  source = "../../modules/nat-gateway"

  name      = "VPC B NATGW"
  subnet_id = module.subnets_b.public_subnet_ids[0]
  tags      = var.tags
}

module "route_tables_b" {
  source = "../../modules/route-tables"

  vpc_id                   = module.vpc_b.vpc_id
  public_subnet_ids        = module.subnets_b.public_subnet_ids
  private_subnet_ids       = module.subnets_b.private_subnet_ids
  igw_id                   = module.igw_b.igw_id
  nat_gateway_id           = module.nat_b.nat_gateway_id
  public_route_table_name  = "VPC B Public Route Table"
  private_route_table_name = "VPC B Private Route Table"
  tags                     = var.tags
}

# ----------------------------------------------------------------------
# VPC C
# ----------------------------------------------------------------------
module "vpc_c" {
  source = "../../modules/vpc"

  name                 = "VPC C"
  cidr_block           = var.vpc_c_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = var.tags
}

module "subnets_c" {
  source = "../../modules/subnets"

  vpc_id               = module.vpc_c.vpc_id
  name_prefix          = "VPC C"
  public_subnet_cidrs  = var.vpc_c_public_subnet_cidrs
  private_subnet_cidrs = var.vpc_c_private_subnet_cidrs
  availability_zones   = var.availability_zones
  tags                 = var.tags
}

# Subnets TGW da VPC C
resource "aws_subnet" "vpc_c_tgw_az1" {
  vpc_id            = module.vpc_c.vpc_id
  cidr_block        = var.vpc_c_tgw_subnet_cidrs[0]
  availability_zone = var.availability_zones[0]

  tags = merge(var.tags, {
    Name = "VPC C TGW Subnet AZ1"
  })
}

resource "aws_subnet" "vpc_c_tgw_az2" {
  vpc_id            = module.vpc_c.vpc_id
  cidr_block        = var.vpc_c_tgw_subnet_cidrs[1]
  availability_zone = var.availability_zones[1]

  tags = merge(var.tags, {
    Name = "VPC C TGW Subnet AZ2"
  })
}

module "igw_c" {
  source = "../../modules/internet-gateway"

  vpc_id = module.vpc_c.vpc_id
  name   = "VPC C IGW"
  tags   = var.tags
}

module "nat_c" {
  source = "../../modules/nat-gateway"

  name      = "VPC C NATGW"
  subnet_id = module.subnets_c.public_subnet_ids[0]
  tags      = var.tags
}

module "route_tables_c" {
  source = "../../modules/route-tables"

  vpc_id                   = module.vpc_c.vpc_id
  public_subnet_ids        = module.subnets_c.public_subnet_ids
  private_subnet_ids       = module.subnets_c.private_subnet_ids
  igw_id                   = module.igw_c.igw_id
  nat_gateway_id           = module.nat_c.nat_gateway_id
  public_route_table_name  = "VPC C Public Route Table"
  private_route_table_name = "VPC C Private Route Table"
  tags                     = var.tags
}

# ----------------------------------------------------------------------
# TRANSIT GATEWAY
# ----------------------------------------------------------------------
module "tgw" {
  source = "../../modules/transit-gateway"

  name                            = "TGW"
  description                     = "Transit Gateway for lab 03"
  amazon_side_asn                 = 64512
  auto_accept_shared_attachments  = "disable"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  vpn_ecmp_support                = "enable"
  dns_support                     = "enable"
  multicast_support               = "enable"
  tags                            = var.tags
}

# Tabelas de rotas do TGW (duas: default e shared services)
resource "aws_ec2_transit_gateway_route_table" "default" {
  transit_gateway_id = module.tgw.transit_gateway_id

  tags = merge(var.tags, {
    Name = "Default TGW Route Table"
  })
}

resource "aws_ec2_transit_gateway_route_table" "shared_services" {
  transit_gateway_id = module.tgw.transit_gateway_id

  tags = merge(var.tags, {
    Name = "Shared Services TGW Route Table"
  })
}

# Anexos das VPCs ao TGW
module "tgw_attachment_a" {
  source = "../../modules/tgw-attachment"

  name               = "VPC A Attachment"
  transit_gateway_id = module.tgw.transit_gateway_id
  vpc_id             = module.vpc_a.vpc_id
  subnet_ids         = [aws_subnet.vpc_a_tgw_az1.id, aws_subnet.vpc_a_tgw_az2.id]
  tags               = var.tags
}

module "tgw_attachment_b" {
  source = "../../modules/tgw-attachment"

  name               = "VPC B Attachment"
  transit_gateway_id = module.tgw.transit_gateway_id
  vpc_id             = module.vpc_b.vpc_id
  subnet_ids         = [aws_subnet.vpc_b_tgw_az1.id, aws_subnet.vpc_b_tgw_az2.id]
  tags               = var.tags
}

module "tgw_attachment_c" {
  source = "../../modules/tgw-attachment"

  name               = "VPC C Attachment"
  transit_gateway_id = module.tgw.transit_gateway_id
  vpc_id             = module.vpc_c.vpc_id
  subnet_ids         = [aws_subnet.vpc_c_tgw_az1.id, aws_subnet.vpc_c_tgw_az2.id]
  tags               = var.tags
}

# Associações e propagações (seguindo o lab 2: VPC A na shared, B e C na default)
resource "aws_ec2_transit_gateway_route_table_association" "vpc_a" {
  transit_gateway_attachment_id  = module.tgw_attachment_a.attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.shared_services.id
}

resource "aws_ec2_transit_gateway_route_table_association" "vpc_b" {
  transit_gateway_attachment_id  = module.tgw_attachment_b.attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.default.id
}

resource "aws_ec2_transit_gateway_route_table_association" "vpc_c" {
  transit_gateway_attachment_id  = module.tgw_attachment_c.attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.default.id
}

# Propagações: VPC A propaga na default, VPC B e C propagam na shared
resource "aws_ec2_transit_gateway_route_table_propagation" "vpc_a_to_default" {
  transit_gateway_attachment_id  = module.tgw_attachment_a.attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.default.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "vpc_b_to_shared" {
  transit_gateway_attachment_id  = module.tgw_attachment_b.attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.shared_services.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "vpc_c_to_shared" {
  transit_gateway_attachment_id  = module.tgw_attachment_c.attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.shared_services.id
}

# Rotas nas tabelas privadas das VPCs apontando para o TGW
resource "aws_route" "vpc_a_to_tgw" {
  route_table_id         = module.route_tables_a.private_route_table_id
  destination_cidr_block = "10.0.0.0/8"
  transit_gateway_id     = module.tgw.transit_gateway_id
  depends_on             = [module.tgw_attachment_a]
}

resource "aws_route" "vpc_b_to_tgw" {
  route_table_id         = module.route_tables_b.private_route_table_id
  destination_cidr_block = "10.0.0.0/8"
  transit_gateway_id     = module.tgw.transit_gateway_id
  depends_on             = [module.tgw_attachment_b]
}

resource "aws_route" "vpc_c_to_tgw" {
  route_table_id         = module.route_tables_c.private_route_table_id
  destination_cidr_block = "10.0.0.0/8"
  transit_gateway_id     = module.tgw.transit_gateway_id
  depends_on             = [module.tgw_attachment_c]
}

# ----------------------------------------------------------------------
# IAM ROLES PARA EC2
# ----------------------------------------------------------------------
module "iam_roles" {
  source = "../../modules/iam-roles"

  role_name             = "NetworkingWorkshopInstanceRole-${var.environment}"
  instance_profile_name = "NetworkingWorkshopInstanceProfile-${var.environment}"
  tags                  = var.tags
}

# ----------------------------------------------------------------------
# SECURITY GROUPS (VAZIOS, APENAS COM DESCRIÇÃO)
# ----------------------------------------------------------------------
resource "aws_security_group" "vpc_a_sg" {
  name        = "VPC A Security Group"
  description = "Security Group for VPC A instances"
  vpc_id      = module.vpc_a.vpc_id

  tags = merge(var.tags, {
    Name = "VPC A Security Group"
  })
}

resource "aws_security_group" "vpc_b_sg" {
  name        = "VPC B Security Group"
  description = "Security Group for VPC B instances"
  vpc_id      = module.vpc_b.vpc_id

  tags = merge(var.tags, {
    Name = "VPC B Security Group"
  })
}

resource "aws_security_group" "vpc_c_sg" {
  name        = "VPC C Security Group"
  description = "Security Group for VPC C instances"
  vpc_id      = module.vpc_c.vpc_id

  tags = merge(var.tags, {
    Name = "VPC C Security Group"
  })
}

# ----------------------------------------------------------------------
# INSTÂNCIAS EC2 (PRIVADAS)
# ----------------------------------------------------------------------
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

module "ec2_a" {
  source = "../../modules/ec2-instance"

  name                   = "VPC A Private AZ1 Server"
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  subnet_id              = module.subnets_a.private_subnet_ids[0]
  private_ip             = var.vpc_a_test_instance_ip
  vpc_security_group_ids = [aws_security_group.vpc_a_sg.id]
  iam_instance_profile   = module.iam_roles.instance_profile_name
  associate_public_ip    = false
  user_data              = file("${path.module}/user_data.sh")
  tags                   = var.tags
}

module "ec2_b" {
  source = "../../modules/ec2-instance"

  name                   = "VPC B Private AZ1 Server"
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  subnet_id              = module.subnets_b.private_subnet_ids[0]
  private_ip             = var.vpc_b_test_instance_ip
  vpc_security_group_ids = [aws_security_group.vpc_b_sg.id]
  iam_instance_profile   = module.iam_roles.instance_profile_name
  associate_public_ip    = false
  user_data              = file("${path.module}/user_data.sh")
  tags                   = var.tags
}

module "ec2_c" {
  source = "../../modules/ec2-instance"

  name                   = "VPC C Private AZ1 Server"
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  subnet_id              = module.subnets_c.private_subnet_ids[0]
  private_ip             = var.vpc_c_test_instance_ip
  vpc_security_group_ids = [aws_security_group.vpc_c_sg.id]
  iam_instance_profile   = module.iam_roles.instance_profile_name
  associate_public_ip    = false
  user_data              = file("${path.module}/user_data.sh")
  tags                   = var.tags
}

# ----------------------------------------------------------------------
# NETWORK ACL DA VPC A (com regras iniciais allow all)
# ----------------------------------------------------------------------
module "nacl_vpc_a" {
  source = "../../modules/network-acl-lab3"

  vpc_id = module.vpc_a.vpc_id
  name   = "VPC A Workload Subnets NACL"

  subnet_ids = concat(
    module.subnets_a.public_subnet_ids,
    module.subnets_a.private_subnet_ids
  )

  inbound_rules = [
    {
      rule_number = 100
      protocol    = "-1"
      action      = "allow"
      cidr_block  = "0.0.0.0/0"
    }
  ]

  outbound_rules = [
    {
      rule_number = 100
      protocol    = "-1"
      action      = "allow"
      cidr_block  = "0.0.0.0/0"
    }
  ]

  tags = var.tags
}

# ----------------------------------------------------------------------
# (FUTURO) MÓDULOS PARA SECURITY GROUP RULES E ENDPOINTS
# ----------------------------------------------------------------------
# Ainda não implementados. Serão adicionados nas próximas etapas.
