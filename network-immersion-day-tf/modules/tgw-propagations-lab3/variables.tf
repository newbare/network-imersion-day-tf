# modules/tgw-propagations-lab3/variables.tf

variable "propagations" {
  description = "Mapa de propagações. Cada chave é um identificador único."
  type = map(object({
    attachment_id  = string
    route_table_id = string
  }))
}

variable "tags" {
  description = "Tags (não usadas diretamente)"
  type        = map(string)
  default     = {}
}
