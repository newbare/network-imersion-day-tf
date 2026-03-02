# modules/vpc/variables.tf

variable "name" {
  description = "Nome da VPC (será usado na tag Name)"
  type        = string
}

variable "cidr_block" {
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

variable "tags" {
  description = "Tags comuns que serão adicionadas à VPC (além da tag Name)"
  type        = map(string)
  default     = {}
}
#lab2
# ... (variáveis existentes) ...

variable "availability_zones" {
  description = "Lista de zonas de disponibilidade para as subnets TGW (deve ter o mesmo tamanho que tgw_subnet_cidrs)"
  type        = list(string)
  default     = []
}

variable "tgw_subnet_cidrs" {
  description = "Lista de CIDRs para subnets dedicadas ao Transit Gateway (opcional). Se fornecido, uma subnet será criada por CIDR."
  type        = list(string)
  default     = []
}

variable "tgw_subnet_names" {
  description = "Lista opcional de nomes para as subnets TGW. Se não fornecido, o nome será gerado automaticamente."
  type        = list(string)
  default     = []
}
