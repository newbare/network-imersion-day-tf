# Variáveis de entrada para o módulo subnets

# modules/subnets/variables.tf

variable "vpc_id" {
  description = "ID da VPC onde as subnets serão criadas"
  type        = string
}

variable "name_prefix" {
  description = "Prefixo para o nome das subnets (ex: 'VPC A')"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Lista de CIDRs para as subnets públicas (deve ter o mesmo tamanho que availability_zones)"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Lista de CIDRs para as subnets privadas (deve ter o mesmo tamanho que availability_zones)"
  type        = list(string)
}

variable "availability_zones" {
  description = "Lista de zonas de disponibilidade (uma para cada subnet)"
  type        = list(string)
}

variable "tags" {
  description = "Tags comuns a serem adicionadas às subnets"
  type        = map(string)
  default     = {}
}