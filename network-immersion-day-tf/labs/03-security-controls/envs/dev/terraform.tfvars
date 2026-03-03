# Configurações para ambiente dev

region             = "us-east-1"
environment        = "dev"
availability_zones = ["us-east-1a", "us-east-1b"]

tags = {
  Environment = "dev"
  ManagedBy   = "terraform"
  Workshop    = "networking-immersion-day"
  Lab         = "03-security-controls"
  Owner       = "team-cloud@acme.com"
}

# CIDRs das VPCs
vpc_a_cidr = "10.0.0.0/16"
vpc_b_cidr = "10.1.0.0/16"
vpc_c_cidr = "10.2.0.0/16"

# Subnets VPC A
vpc_a_public_subnet_cidrs  = ["10.0.0.0/24", "10.0.2.0/24"]
vpc_a_private_subnet_cidrs = ["10.0.1.0/24", "10.0.3.0/24"]
vpc_a_tgw_subnet_cidrs     = ["10.0.5.0/28", "10.0.5.16/28"]

# Subnets VPC B
vpc_b_public_subnet_cidrs  = ["10.1.0.0/24", "10.1.2.0/24"]
vpc_b_private_subnet_cidrs = ["10.1.1.0/24", "10.1.3.0/24"]
vpc_b_tgw_subnet_cidrs     = ["10.1.5.0/28", "10.1.5.16/28"]

# Subnets VPC C
vpc_c_public_subnet_cidrs  = ["10.2.0.0/24", "10.2.2.0/24"]
vpc_c_private_subnet_cidrs = ["10.2.1.0/24", "10.2.3.0/24"]
vpc_c_tgw_subnet_cidrs     = ["10.2.5.0/28", "10.2.5.16/28"]

# IPs das instâncias de teste
vpc_a_test_instance_ip = "10.0.1.100"
vpc_b_test_instance_ip = "10.1.1.100"
vpc_c_test_instance_ip = "10.2.1.100"

# Outros
my_ip_cidr    = "0.0.0.0/0" # Substitua pelo seu IP, ex: "123.45.67.89/32"
instance_type = "t3.micro"
