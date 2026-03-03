# modules/tgw-subnets-lab3/variables.tf
variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "subnet_cidrs" {
  description = "Lista de CIDRs para as subnets TGW"
  type        = list(string)
}

variable "availability_zones" {
  description = "Lista de zonas de disponibilidade (mesmo tamanho de subnet_cidrs)"
  type        = list(string)
}

variable "subnet_names" {
  description = "Nomes opcionais para as subnets"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags comuns"
  type        = map(string)
  default     = {}
}
