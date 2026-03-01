# Variáveis do laboratório 01-vpc-fundamentals - labs/01-vpc-fundamentals/variables.tf

variable "environment" {
  description = "Ambiente (ex: dev, stage, prod)"
  type        = string
}

variable "region" {
  description = "Região AWS onde os recursos serão criados"
  type        = string
  default     = "us-east-1"
}

# Variáveis para a VPC
variable "vpc_name" {
  description = "Nome da VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "Bloco CIDR da VPC"
  type        = string
}

variable "enable_dns_hostnames" {
  description = "Habilitar DNS hostnames na VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Habilitar suporte DNS na VPC"
  type        = bool
  default     = true
}

# Variável tags ainda disponível para sobrescritas específicas
variable "tags" {
  description = "Tags adicionais (sobrescrevem default_tags se houver conflito)"
  type        = map(string)
  default     = {}
}

# Variáveis para as subnets

variable "public_subnet_cidrs" {
  description = "Lista de CIDRs para as subnets públicas"
  type        = list(string)
}



variable "availability_zones" {
  description = "Lista de zonas de disponibilidade"
  type        = list(string)
}

# vpc endpoints
variable "private_subnet_cidrs" {
  description = "Lista de CIDRs das subnets privadas"
  type        = list(string)
}

# security groups
variable "my_ip_cidr" {
  description = "Seu endereço IP público no formato CIDR (ex: 187.23.45.67/32)"
  type        = string
}
