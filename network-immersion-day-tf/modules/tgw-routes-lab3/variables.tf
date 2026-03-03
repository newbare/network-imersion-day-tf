# modules/tgw-routes-lab3/variables.tf

variable "transit_gateway_id" {
  description = "ID do Transit Gateway"
  type        = string
}

variable "routes" {
  description = "Mapa de rotas a serem criadas"
  type = map(object({
    route_table_id         = string
    destination_cidr_block = string
  }))
}

variable "tags" {
  description = "Tags adicionais (não usadas diretamente)"
  type        = map(string)
  default     = {}
}
