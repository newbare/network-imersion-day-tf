# modules/tgw-associations-lab3/variables.tf

variable "associations" {
  description = "Mapa de associações. Cada chave é um identificador único."
  type = map(object({
    attachment_id  = string
    route_table_id = string
  }))
}

variable "tags" {
  description = "Tags (não usadas diretamente, mas para consistência)"
  type        = map(string)
  default     = {}
}
