# Configuração principal do laboratório 03-security-controls
# SEM NENHUM RESOURCE AVULSO - TUDO MODULARIZADO

# ======================================================================
# INFRAESTRUTURA BASE
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

module "subnets_a" {
  source = "../../modules/subnets"

  vpc_id               = module.vpc_a.vpc_id
  name_prefix          = "VPC A"
  public_subnet_cidrs  = var.vpc_a_public_subnet_cidrs
  private_subnet_cidrs = var.vpc_a_private_subnet_cidrs
  availability_zones   = var.availability_zones
  tags                 = var.tags
}

module "tgw_subnets_a" {
  source = "../../modules/tgw-subnets-lab3"

  vpc_id             = module.vpc_a.vpc_id
  subnet_cidrs       = var.vpc_a_tgw_subnet_cidrs
  availability_zones = var.availability_zones
  subnet_names       = ["VPC A TGW Subnet AZ1", "VPC A TGW Subnet AZ2"]
  tags               = var.tags
}

module "igw_a" {
  source = "../../modules/internet-gateway"

  vpc_id = module.vpc_a.vpc_id
  name   = "VPC A IGW"
  tags   = var.tags
}

module "nat_a" {
  source = "../../modules/nat-gateway"

  name      = "VPC A NATGW"
  subnet_id = module.subnets_a.public_subnet_ids[0]
  tags      = var.tags
}

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

module "tgw_subnets_b" {
  source = "../../modules/tgw-subnets-lab3"

  vpc_id             = module.vpc_b.vpc_id
  subnet_cidrs       = var.vpc_b_tgw_subnet_cidrs
  availability_zones = var.availability_zones
  subnet_names       = ["VPC B TGW Subnet AZ1", "VPC B TGW Subnet AZ2"]
  tags               = var.tags
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

module "tgw_subnets_c" {
  source = "../../modules/tgw-subnets-lab3"

  vpc_id             = module.vpc_c.vpc_id
  subnet_cidrs       = var.vpc_c_tgw_subnet_cidrs
  availability_zones = var.availability_zones
  subnet_names       = ["VPC C TGW Subnet AZ1", "VPC C TGW Subnet AZ2"]
  tags               = var.tags
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

# Módulo para as tabelas de rotas do TGW
module "tgw_route_tables" {
  source = "../../modules/tgw-route-tables-lab3"

  transit_gateway_id = module.tgw.transit_gateway_id
  tags               = var.tags
}

# Anexos das VPCs ao TGW
module "tgw_attachment_a" {
  source = "../../modules/tgw-attachment"

  name               = "VPC A Attachment"
  transit_gateway_id = module.tgw.transit_gateway_id
  vpc_id             = module.vpc_a.vpc_id
  subnet_ids         = module.tgw_subnets_a.subnet_ids
  tags               = var.tags
}

module "tgw_attachment_b" {
  source = "../../modules/tgw-attachment"

  name               = "VPC B Attachment"
  transit_gateway_id = module.tgw.transit_gateway_id
  vpc_id             = module.vpc_b.vpc_id
  subnet_ids         = module.tgw_subnets_b.subnet_ids
  tags               = var.tags
}

module "tgw_attachment_c" {
  source = "../../modules/tgw-attachment"

  name               = "VPC C Attachment"
  transit_gateway_id = module.tgw.transit_gateway_id
  vpc_id             = module.vpc_c.vpc_id
  subnet_ids         = module.tgw_subnets_c.subnet_ids
  tags               = var.tags
}

# Associações das VPCs às tabelas de rotas
module "tgw_associations" {
  source = "../../modules/tgw-associations-lab3"

  associations = {
    vpc_a = {
      attachment_id  = module.tgw_attachment_a.attachment_id
      route_table_id = module.tgw_route_tables.shared_services_route_table_id
    }
    vpc_b = {
      attachment_id  = module.tgw_attachment_b.attachment_id
      route_table_id = module.tgw_route_tables.default_route_table_id
    }
    vpc_c = {
      attachment_id  = module.tgw_attachment_c.attachment_id
      route_table_id = module.tgw_route_tables.default_route_table_id
    }
  }
  tags = var.tags
}

# Propagações
module "tgw_propagations" {
  source = "../../modules/tgw-propagations-lab3"

  propagations = {
    vpc_a_to_default = {
      attachment_id  = module.tgw_attachment_a.attachment_id
      route_table_id = module.tgw_route_tables.default_route_table_id
    }
    vpc_b_to_shared = {
      attachment_id  = module.tgw_attachment_b.attachment_id
      route_table_id = module.tgw_route_tables.shared_services_route_table_id
    }
    vpc_c_to_shared = {
      attachment_id  = module.tgw_attachment_c.attachment_id
      route_table_id = module.tgw_route_tables.shared_services_route_table_id
    }
  }
  tags = var.tags
}

# Rotas nas tabelas privadas das VPCs apontando para o TGW
module "tgw_routes" {
  source = "../../modules/tgw-routes-lab3"

  transit_gateway_id = module.tgw.transit_gateway_id

  routes = {
    vpc_a = {
      route_table_id         = module.route_tables_a.private_route_table_id
      destination_cidr_block = "10.0.0.0/8"
    }
    vpc_b = {
      route_table_id         = module.route_tables_b.private_route_table_id
      destination_cidr_block = "10.0.0.0/8"
    }
    vpc_c = {
      route_table_id         = module.route_tables_c.private_route_table_id
      destination_cidr_block = "10.0.0.0/8"
    }
  }

  tags = var.tags
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
# SECURITY GROUPS (VAZIOS)
# ----------------------------------------------------------------------
module "security_group_a" {
  source = "../../modules/security-group-lab3"

  name        = "VPC A Security Group"
  description = "Security Group for VPC A instances"
  vpc_id      = module.vpc_a.vpc_id
  tags        = var.tags
}

module "security_group_b" {
  source = "../../modules/security-group-lab3"

  name        = "VPC B Security Group"
  description = "Security Group for VPC B instances"
  vpc_id      = module.vpc_b.vpc_id
  tags        = var.tags
}

module "security_group_c" {
  source = "../../modules/security-group-lab3"

  name        = "VPC C Security Group"
  description = "Security Group for VPC C instances"
  vpc_id      = module.vpc_c.vpc_id
  tags        = var.tags
}

# ----------------------------------------------------------------------
# INSTÂNCIAS EC2
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
  vpc_security_group_ids = [module.security_group_a.security_group_id]
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
  vpc_security_group_ids = [module.security_group_b.security_group_id]
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
  vpc_security_group_ids = [module.security_group_c.security_group_id]
  iam_instance_profile   = module.iam_roles.instance_profile_name
  associate_public_ip    = false
  user_data              = file("${path.module}/user_data.sh")
  tags                   = var.tags
}

# ----------------------------------------------------------------------
# NETWORK ACL DA VPC A
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
# REGRAS INICIAIS DOS SECURITY GROUPS
# ----------------------------------------------------------------------
module "sg_rules_vpc_a" {
  source = "../../modules/security-group-rules-lab3"

  security_group_id = module.security_group_a.security_group_id

  ingress_rules = {
    "icmp-10-0-0-0-8" = {
      description = "ICMP from 10.0.0.0/8"
      ip_protocol = "icmp"
      from_port   = -1
      to_port     = -1
      cidr_ipv4   = "10.0.0.0/8"
    }
    "icmp-172-16-0-0-16" = {
      description = "ICMP from 172.16.0.0/16"
      ip_protocol = "icmp"
      from_port   = -1
      to_port     = -1
      cidr_ipv4   = "172.16.0.0/16"
    }
    "icmp-participant" = {
      description = "ICMP from participant IP"
      ip_protocol = "icmp"
      from_port   = -1
      to_port     = -1
      cidr_ipv4   = var.my_ip_cidr
    }
  }

  tags = var.tags
}

module "sg_rules_vpc_b" {
  source = "../../modules/security-group-rules-lab3"

  security_group_id = module.security_group_b.security_group_id

  ingress_rules = {
    "icmp-10-0-0-0-8" = {
      description = "ICMP from 10.0.0.0/8"
      ip_protocol = "icmp"
      from_port   = -1
      to_port     = -1
      cidr_ipv4   = "10.0.0.0/8"
    }
    "icmp-172-16-0-0-16" = {
      description = "ICMP from 172.16.0.0/16"
      ip_protocol = "icmp"
      from_port   = -1
      to_port     = -1
      cidr_ipv4   = "172.16.0.0/16"
    }
    "icmp-participant" = {
      description = "ICMP from participant IP"
      ip_protocol = "icmp"
      from_port   = -1
      to_port     = -1
      cidr_ipv4   = var.my_ip_cidr
    }
  }

  tags = var.tags
}

module "sg_rules_vpc_c" {
  source = "../../modules/security-group-rules-lab3"

  security_group_id = module.security_group_c.security_group_id

  ingress_rules = {
    "icmp-10-0-0-0-8" = {
      description = "ICMP from 10.0.0.0/8"
      ip_protocol = "icmp"
      from_port   = -1
      to_port     = -1
      cidr_ipv4   = "10.0.0.0/8"
    }
    "icmp-172-16-0-0-16" = {
      description = "ICMP from 172.16.0.0/16"
      ip_protocol = "icmp"
      from_port   = -1
      to_port     = -1
      cidr_ipv4   = "172.16.0.0/16"
    }
    "icmp-participant" = {
      description = "ICMP from participant IP"
      ip_protocol = "icmp"
      from_port   = -1
      to_port     = -1
      cidr_ipv4   = var.my_ip_cidr
    }
  }

  tags = var.tags
}
