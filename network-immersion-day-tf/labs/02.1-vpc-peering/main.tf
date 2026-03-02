#lab2.1 vpc peering

# VPC A
module "vpc_a" {
  source = "../../modules/vpc"

  name                 = "VPC A"
  cidr_block           = var.vpc_a_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = var.tags
}

# VPC B
module "vpc_b" {
  source = "../../modules/vpc"

  name                 = "VPC B"
  cidr_block           = var.vpc_b_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = var.tags
}

# VPC C
module "vpc_c" {
  source = "../../modules/vpc"

  name                 = "VPC C"
  cidr_block           = var.vpc_c_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = var.tags
}

# Subnets para VPC A
module "subnets_a" {
  source = "../../modules/subnets"

  vpc_id               = module.vpc_a.vpc_id
  name_prefix          = "VPC A"
  public_subnet_cidrs  = var.vpc_a_public_subnet_cidrs
  private_subnet_cidrs = var.vpc_a_private_subnet_cidrs
  availability_zones   = var.availability_zones
  tags                 = var.tags
}

# Subnets para VPC B
module "subnets_b" {
  source = "../../modules/subnets"

  vpc_id               = module.vpc_b.vpc_id
  name_prefix          = "VPC B"
  public_subnet_cidrs  = var.vpc_b_public_subnet_cidrs
  private_subnet_cidrs = var.vpc_b_private_subnet_cidrs
  availability_zones   = var.availability_zones
  tags                 = var.tags
}

# Subnets para VPC C
module "subnets_c" {
  source = "../../modules/subnets"

  vpc_id               = module.vpc_c.vpc_id
  name_prefix          = "VPC C"
  public_subnet_cidrs  = var.vpc_c_public_subnet_cidrs
  private_subnet_cidrs = var.vpc_c_private_subnet_cidrs
  availability_zones   = var.availability_zones
  tags                 = var.tags
}

# Tabelas de rota para VPC A
module "route_tables_a" {
  source = "../../modules/route-tables"

  vpc_id                   = module.vpc_a.vpc_id
  public_subnet_ids        = module.subnets_a.public_subnet_ids
  private_subnet_ids       = module.subnets_a.private_subnet_ids
  igw_id                   = null
  nat_gateway_id           = null
  public_route_table_name  = "VPC A Public Route Table"
  private_route_table_name = "VPC A Private Route Table"
  tags                     = var.tags
}

# Tabelas de rota para VPC B
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

# Tabelas de rota para VPC C
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

# IAM Role para EC2
module "iam_roles" {
  source = "../../modules/iam-roles"

  role_name             = var.iam_role_name
  instance_profile_name = var.iam_instance_profile_name
  tags                  = var.tags
}

# AMI
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

# Security Groups
module "sg_vpc_a" {
  source = "../../modules/security-groups-lab2"

  name        = "VPC A Test SG"
  description = "Permite ICMP de VPC B e VPC C"
  vpc_id      = module.vpc_a.vpc_id
  ingress_rules = [
    {
      from_port   = -1
      to_port     = -1
      protocol    = "icmp"
      cidr_blocks = [var.vpc_b_cidr, var.vpc_c_cidr]
      description = "ICMP from VPC B and VPC C"
    }
  ]
  tags = var.tags
}

module "sg_vpc_b" {
  source = "../../modules/security-groups-lab2"

  name        = "VPC B Test SG"
  description = "Permite ICMP de VPC A e VPC C"
  vpc_id      = module.vpc_b.vpc_id
  ingress_rules = [
    {
      from_port   = -1
      to_port     = -1
      protocol    = "icmp"
      cidr_blocks = [var.vpc_a_cidr, var.vpc_c_cidr]
      description = "ICMP from VPC A and VPC C"
    }
  ]
  tags = var.tags
}

module "sg_vpc_c" {
  source = "../../modules/security-groups-lab2"

  name        = "VPC C Test SG"
  description = "Permite ICMP de VPC A e VPC B"
  vpc_id      = module.vpc_c.vpc_id
  ingress_rules = [
    {
      from_port   = -1
      to_port     = -1
      protocol    = "icmp"
      cidr_blocks = [var.vpc_a_cidr, var.vpc_b_cidr]
      description = "ICMP from VPC A and VPC B"
    }
  ]
  tags = var.tags
}

# Instâncias EC2
module "ec2_a" {
  source = "../../modules/ec2-instance"

  name                   = "VPC A Private AZ1 Server"
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  subnet_id              = module.subnets_a.private_subnet_ids[0]
  private_ip             = var.vpc_a_test_instance_ip
  vpc_security_group_ids = [module.sg_vpc_a.security_group_id]
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
  vpc_security_group_ids = [module.sg_vpc_b.security_group_id]
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
  vpc_security_group_ids = [module.sg_vpc_c.security_group_id]
  iam_instance_profile   = module.iam_roles.instance_profile_name
  associate_public_ip    = false
  user_data              = file("${path.module}/user_data.sh")
  tags                   = var.tags
}

# Peering connections
module "vpc_peering_ab" {
  source = "../../modules/vpc-peering"

  peering_connections = {
    ab = {
      requester_vpc_id = module.vpc_a.vpc_id
      accepter_vpc_id  = module.vpc_b.vpc_id
      name             = "VPC A <> VPC B"
    }
  }
  tags = var.tags
}

module "vpc_peering_ac" {
  source = "../../modules/vpc-peering"

  peering_connections = {
    ac = {
      requester_vpc_id = module.vpc_a.vpc_id
      accepter_vpc_id  = module.vpc_c.vpc_id
      name             = "VPC A <> VPC C"
    }
  }
  tags = var.tags
}

# Rotas de peering
module "peering_routes_a_to_b" {
  source = "../../modules/vpc-peering-routes"

  peering_connection_id = module.vpc_peering_ab.peering_ids["ab"]
  routes = {
    to_b = {
      route_table_id   = module.route_tables_a.private_route_table_id
      destination_cidr = var.vpc_b_cidr
    }
  }
  depends_on = [module.vpc_peering_ab, module.route_tables_a]

}

module "peering_routes_a_to_c" {
  source = "../../modules/vpc-peering-routes"

  peering_connection_id = module.vpc_peering_ac.peering_ids["ac"]
  routes = {
    to_c = {
      route_table_id   = module.route_tables_a.private_route_table_id
      destination_cidr = var.vpc_c_cidr
    }
  }
  depends_on = [module.vpc_peering_ac, module.route_tables_a]

}

module "peering_routes_b_to_a" {
  source = "../../modules/vpc-peering-routes"

  peering_connection_id = module.vpc_peering_ab.peering_ids["ab"]
  routes = {
    to_a = {
      route_table_id   = module.route_tables_b.private_route_table_id
      destination_cidr = var.vpc_a_cidr
    }
  }
  depends_on = [module.vpc_peering_ab, module.route_tables_b]
}

module "peering_routes_c_to_a" {
  source = "../../modules/vpc-peering-routes"

  peering_connection_id = module.vpc_peering_ac.peering_ids["ac"]
  routes = {
    to_a = {
      route_table_id   = module.route_tables_c.private_route_table_id
      destination_cidr = var.vpc_a_cidr
    }
  }
  depends_on = [module.vpc_peering_ac, module.route_tables_c]

}
