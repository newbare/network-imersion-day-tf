# Variáveis do laboratório 03-security-controls

# Variáveis gerais
variable "region" {
  description = "AWS region"
  type        = string
}

variable "environment" {
  description = "Ambiente (dev, stage, prod)"
  type        = string
}

variable "tags" {
  description = "Tags comuns para todos os recursos"
  type        = map(string)
}

# Variáveis de rede
variable "availability_zones" {
  description = "Lista de zonas de disponibilidade"
  type        = list(string)
}

variable "vpc_a_cidr" {
  description = "CIDR da VPC A"
  type        = string
}

variable "vpc_b_cidr" {
  description = "CIDR da VPC B"
  type        = string
}

variable "vpc_c_cidr" {
  description = "CIDR da VPC C"
  type        = string
}

# Subnets VPC A
variable "vpc_a_public_subnet_cidrs" {
  description = "CIDRs das subnets públicas da VPC A"
  type        = list(string)
}

variable "vpc_a_private_subnet_cidrs" {
  description = "CIDRs das subnets privadas da VPC A"
  type        = list(string)
}

variable "vpc_a_tgw_subnet_cidrs" {
  description = "CIDRs das subnets TGW da VPC A (/28)"
  type        = list(string)
}

# Subnets VPC B
variable "vpc_b_public_subnet_cidrs" {
  description = "CIDRs das subnets públicas da VPC B"
  type        = list(string)
}

variable "vpc_b_private_subnet_cidrs" {
  description = "CIDRs das subnets privadas da VPC B"
  type        = list(string)
}

variable "vpc_b_tgw_subnet_cidrs" {
  description = "CIDRs das subnets TGW da VPC B (/28)"
  type        = list(string)
}

# Subnets VPC C
variable "vpc_c_public_subnet_cidrs" {
  description = "CIDRs das subnets públicas da VPC C"
  type        = list(string)
}

variable "vpc_c_private_subnet_cidrs" {
  description = "CIDRs das subnets privadas da VPC C"
  type        = list(string)
}

variable "vpc_c_tgw_subnet_cidrs" {
  description = "CIDRs das subnets TGW da VPC C (/28)"
  type        = list(string)
}

# IPs das instâncias de teste
variable "vpc_a_test_instance_ip" {
  description = "IP privado da instância de teste na VPC A"
  type        = string
}

variable "vpc_b_test_instance_ip" {
  description = "IP privado da instância de teste na VPC B"
  type        = string
}

variable "vpc_c_test_instance_ip" {
  description = "IP privado da instância de teste na VPC C"
  type        = string
}

# Outras variáveis
variable "my_ip_cidr" {
  description = "Seu IP público no formato x.x.x.x/32 para acesso SSH (opcional)"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instância EC2"
  type        = string
}
