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

# tags adicionais se necessário
tags = {}

# ... (outras variáveis)
tgw_name               = "TGW"
tgw_description        = "TGW for us-east-1"
tgw_multicast_support  = "enable"   # habilitado conforme tutorial
# as demais usam o default
