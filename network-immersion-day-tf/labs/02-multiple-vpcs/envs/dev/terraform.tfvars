# Configurações para ambiente dev
environment        = "dev"
region             = "us-east-1"
availability_zones = ["us-east-1a", "us-east-1b"]

vpc_a_cidr = "10.0.0.0/16"
vpc_b_cidr = "10.1.0.0/16"
vpc_c_cidr = "10.2.0.0/16"

vpc_a_tgw_subnet_cidrs = ["10.0.5.0/28", "10.0.5.16/28"]
vpc_b_tgw_subnet_cidrs = ["10.1.5.0/28", "10.1.5.16/28"]
vpc_c_tgw_subnet_cidrs = ["10.2.5.0/28", "10.2.5.16/28"]

vpc_a_public_subnet_cidrs  = ["10.0.0.0/24", "10.0.2.0/24"]
vpc_a_private_subnet_cidrs = ["10.0.1.0/24", "10.0.3.0/24"]

vpc_b_public_subnet_cidrs  = ["10.1.0.0/24", "10.1.2.0/24"]
vpc_b_private_subnet_cidrs = ["10.1.1.0/24", "10.1.3.0/24"]

vpc_c_public_subnet_cidrs  = ["10.2.0.0/24", "10.2.2.0/24"]
vpc_c_private_subnet_cidrs = ["10.2.1.0/24", "10.2.3.0/24"]

iam_role_name             = "NetworkingWorkshopInstanceRole-lab2-dev"
iam_instance_profile_name = "NetworkingWorkshopInstanceProfile-lab2-dev"

# TGW (opcional, mas usado)
tgw_name              = "TGW"
tgw_description       = "TGW for us-east-1"
tgw_multicast_support = "enable" # habilitado conforme tutorial

# 🔹 NOVOS VALORES PARA AS INSTÂNCIAS
instance_type          = "t2.micro"
vpc_a_test_instance_ip = "10.0.1.100"
vpc_b_test_instance_ip = "10.1.1.100"
vpc_c_test_instance_ip = "10.2.1.100"
