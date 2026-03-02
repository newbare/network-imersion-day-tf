# modules/tgw-routes-tables/variables.tf

variable "route_table_id" {
  description = "ID da tabela de rotas onde as rotas serão adicionadas"
  type        = string
}

variable "routes" {
  description = "Lista de rotas. Cada rota tem destination (CIDR) e transit_gateway_id"
  type = list(object({
    destination        = string
    transit_gateway_id = string
  }))
}
