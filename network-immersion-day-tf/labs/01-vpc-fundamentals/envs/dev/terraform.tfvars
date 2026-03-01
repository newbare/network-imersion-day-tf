# laboratório 01-vpc-fundamentals

# labs/01-vpc-fundamentals/terraform.tfvars

# VPC Fundamentals - Variáveis para o laboratório 01-vpc-fundamentals
environment = "dev"
region      = "us-east-1"

# Variáveis específicas para a VPC
vpc_name             = "VPC A"
vpc_cidr             = "10.0.0.0/16"
enable_dns_hostnames = true
enable_dns_support   = true


# Subnets
public_subnet_cidrs  = ["10.0.0.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.1.0/24", "10.0.3.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]

# meu ip para liberar acesso via security group (exemplo: "
my_ip_cidr = "177.40.221.6/32" # substitua pelo seu IP real
