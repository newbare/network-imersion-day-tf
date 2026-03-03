# modules/security-group-rules-lab3/variables.tf

variable "security_group_id" {
  description = "ID do security group onde as regras serão aplicadas"
  type        = string
}

variable "ingress_rules" {
  description = "Mapa de regras de entrada. Cada chave é um identificador único para a regra."
  type = map(object({
    description                  = optional(string)
    from_port                    = number
    to_port                      = number
    ip_protocol                  = string
    cidr_ipv4                    = optional(string)
    cidr_ipv6                    = optional(string)
    prefix_list_id               = optional(string)
    referenced_security_group_id = optional(string)
    tags                         = optional(map(string))
  }))
  default = {}
}

variable "egress_rules" {
  description = "Mapa de regras de saída. Mesmo formato das regras de entrada."
  type = map(object({
    description                  = optional(string)
    from_port                    = number
    to_port                      = number
    ip_protocol                  = string
    cidr_ipv4                    = optional(string)
    cidr_ipv6                    = optional(string)
    prefix_list_id               = optional(string)
    referenced_security_group_id = optional(string)
    tags                         = optional(map(string))
  }))
  default = {}
}

variable "tags" {
  description = "Tags adicionais para as regras"
  type        = map(string)
  default     = {}
}
