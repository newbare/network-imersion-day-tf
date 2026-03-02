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
  description = "Lista de zonas de disponibilidade"
  type        = list(string)
}

# VPC A
variable "vpc_a_cidr" {
  description = "CIDR da VPC A"
  type        = string
}

variable "vpc_a_tgw_subnet_cidrs" {
  description = "Lista de CIDRs para subnets TGW da VPC A"
  type        = list(string)
}

# VPC B
variable "vpc_b_cidr" {
  description = "CIDR da VPC B"
  type        = string
}

variable "vpc_b_tgw_subnet_cidrs" {
  description = "Lista de CIDRs para subnets TGW da VPC B"
  type        = list(string)
}

# VPC C
variable "vpc_c_cidr" {
  description = "CIDR da VPC C"
  type        = string
}

variable "vpc_c_tgw_subnet_cidrs" {
  description = "Lista de CIDRs para subnets TGW da VPC C"
  type        = list(string)
}

# Tags adicionais
variable "tags" {
  description = "Tags adicionais (mescladas com as default_tags)"
  type        = map(string)
  default     = {}
}

# Transit Gateway
variable "tgw_name" {
  description = "Nome do Transit Gateway"
  type        = string
  default     = "TGW"
}

variable "tgw_description" {
  description = "Descrição do Transit Gateway"
  type        = string
  default     = "TGW for us-east-1"
}

variable "tgw_multicast_support" {
  description = "Habilitar suporte a multicast (enable/disable)"
  type        = string
  default     = "disable"
}

variable "tgw_amazon_side_asn" {
  description = "Número ASN privado"
  type        = number
  default     = 64512
}

variable "tgw_auto_accept_shared_attachments" {
  description = "Auto aceitar anexos compartilhados"
  type        = string
  default     = "disable"
}

variable "tgw_default_route_table_association" {
  description = "Associar automaticamente à tabela padrão"
  type        = string
  default     = "enable"
}

variable "tgw_default_route_table_propagation" {
  description = "Propagar automaticamente à tabela padrão"
  type        = string
  default     = "enable"
}

variable "tgw_vpn_ecmp_support" {
  description = "Suporte a ECMP para VPN"
  type        = string
  default     = "enable"
}

variable "tgw_dns_support" {
  description = "Suporte a DNS"
  type        = string
  default     = "enable"
}

# Subnets públicas e privadas
variable "vpc_a_public_subnet_cidrs" {
  description = "Lista de CIDRs para subnets públicas da VPC A"
  type        = list(string)
}

variable "vpc_a_private_subnet_cidrs" {
  description = "Lista de CIDRs para subnets privadas da VPC A"
  type        = list(string)
}

variable "vpc_b_public_subnet_cidrs" {
  description = "Lista de CIDRs para subnets públicas da VPC B"
  type        = list(string)
}

variable "vpc_b_private_subnet_cidrs" {
  description = "Lista de CIDRs para subnets privadas da VPC B"
  type        = list(string)
}

variable "vpc_c_public_subnet_cidrs" {
  description = "Lista de CIDRs para subnets públicas da VPC C"
  type        = list(string)
}

variable "vpc_c_private_subnet_cidrs" {
  description = "Lista de CIDRs para subnets privadas da VPC C"
  type        = list(string)
}

# IAM
variable "iam_role_name" {
  description = "Nome da IAM Role para as instâncias do Lab02"
  type        = string
}

variable "iam_instance_profile_name" {
  description = "Nome do Instance Profile para o Lab02"
  type        = string
}

# 🔹 NOVAS VARIÁVEIS PARA AS INSTÂNCIAS
variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t2.micro"
}

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
