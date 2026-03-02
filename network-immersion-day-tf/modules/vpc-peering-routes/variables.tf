# module/vpc-peering-routes/variables.tf

variable "peering_connection_id" {
  description = "ID da conexão de peering que será usada como alvo das rotas."
  type        = string
}

variable "routes" {
  description = "Mapa de rotas a serem adicionadas. Cada rota deve conter route_table_id e destination_cidr."
  type = map(object({
    route_table_id   = string
    destination_cidr = string
  }))
}
