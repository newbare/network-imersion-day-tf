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
