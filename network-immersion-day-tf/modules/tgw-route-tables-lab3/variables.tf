# modules/tgw-route-tables-lab3/variables.tf

variable "transit_gateway_id" {
  description = "ID do Transit Gateway"
  type        = string
}

variable "default_route_table_name" {
  description = "Nome da tabela de rotas padrão"
  type        = string
  default     = "Default TGW Route Table"
}

variable "shared_services_route_table_name" {
  description = "Nome da tabela de rotas de serviços compartilhados"
  type        = string
  default     = "Shared Services TGW Route Table"
}

variable "tags" {
  description = "Tags comuns"
  type        = map(string)
  default     = {}
}
