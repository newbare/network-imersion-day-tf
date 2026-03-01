#modules/nat-gateway/variables.tf

variable "name" {
  description = "Nome do NAT Gateway"
  type        = string
}

variable "subnet_id" {
  description = "ID da subnet pública onde o NAT Gateway será implantado"
  type        = string
}

variable "tags" {
  description = "Tags adicionais"
  type        = map(string)
  default     = {}
}
