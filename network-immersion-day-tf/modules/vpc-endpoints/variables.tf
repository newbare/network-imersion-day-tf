# Variáveis de entrada para o módulo vpc-endpoints

variable "vpc_id" {
  description = "ID da VPC onde os endpoints serão criados"
  type        = string
}

variable "region" {
  description = "Região AWS (usada para formar o service_name)"
  type        = string
}

variable "private_subnet_ids" {
  description = "Lista de IDs das subnets privadas para o endpoint de interface"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Lista de IDs dos security groups para o endpoint de interface"
  type        = list(string)
  default     = []
}

variable "route_table_ids" {
  description = "Lista de IDs das tabelas de rota para o endpoint de gateway"
  type        = list(string)
}

variable "enable_private_dns" {
  description = "Habilitar DNS privado para o endpoint de interface"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags adicionais"
  type        = map(string)
  default     = {}
}


# Variáveis para endpoints de interface adicionais (lab2.1)
variable "interface_endpoints" {
  description = "Mapa de endpoints de interface. Cada entrada deve conter service_name, name, e opcionalmente security_group_ids e private_dns_enabled."
  type = map(object({
    service_name        = string
    name                = string
    security_group_ids  = optional(list(string))
    private_dns_enabled = optional(bool)
  }))
  default = {}
}

variable "gateway_endpoints" {
  description = "Mapa de endpoints de gateway. Cada entrada deve conter service_name, name, e opcionalmente route_table_ids."
  type = map(object({
    service_name    = string
    name            = string
    route_table_ids = optional(list(string))
  }))
  default = {}
}

variable "create_legacy_endpoints" {
  description = "Se true, cria os endpoints fixos KMS e S3 (para compatibilidade com Lab1)"
  type        = bool
  default     = false # Padrão falso para não afetar labs novos
}
