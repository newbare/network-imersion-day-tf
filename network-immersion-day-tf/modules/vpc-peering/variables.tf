# Variáveis de entrada para o módulo vpc-peering

variable "peering_connections" {
  description = "Mapa de conexões de peering. Cada entrada deve conter: requester_vpc_id, accepter_vpc_id e name."
  type = map(object({
    requester_vpc_id = string
    accepter_vpc_id  = string
    name             = string
  }))
}

variable "tags" {
  description = "Tags comuns a serem adicionadas à conexão de peering."
  type        = map(string)
  default     = {}
}
