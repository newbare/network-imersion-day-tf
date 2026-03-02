# Variáveis do laboratório 02-multiple-vpcs

# labs/02-multiple-vpcs/variables.tf
variable "environment" {
  description = "Ambiente (dev, stage, prod)"
  type        = string
}

variable "region" {
  description = "Região AWS"
  type        = string
  default     = "us-east-1"
}

variable "availability_zones" {
  description = "Lista de zonas de disponibilidade (ex: [\"us-east-1a\", \"us-east-1b\"])"
  type        = list(string)
}

# VPC A
variable "vpc_a_cidr" {
  description = "CIDR da VPC A"
  type        = string
}

variable "vpc_a_tgw_subnet_cidrs" {
  description = "Lista de CIDRs para subnets TGW da VPC A (uma por AZ)"
  type        = list(string)
}

# VPC B
variable "vpc_b_cidr" {
  description = "CIDR da VPC B"
  type        = string
}

variable "vpc_b_tgw_subnet_cidrs" {
  description = "Lista de CIDRs para subnets TGW da VPC B (uma por AZ)"
  type        = list(string)
}

# VPC C
variable "vpc_c_cidr" {
  description = "CIDR da VPC C"
  type        = string
}

variable "vpc_c_tgw_subnet_cidrs" {
  description = "Lista de CIDRs para subnets TGW da VPC C (uma por AZ)"
  type        = list(string)
}

# Tags adicionais (opcional, caso queira sobrescrever algo)
variable "tags" {
  description = "Tags adicionais (mescladas com as default_tags)"
  type        = map(string)
  default     = {}
}
