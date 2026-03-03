# module/network-acl-lab3/variables.tf --- IGNORE ---

variable "vpc_id" {
  description = "ID da VPC onde a NACL será criada"
  type        = string
}

variable "name" {
  description = "Nome da NACL (tag Name)"
  type        = string
}

variable "subnet_ids" {
  description = "Lista de IDs das subnets a serem associadas a esta NACL"
  type        = list(string)
  default     = []
}

variable "inbound_rules" {
  description = "Lista de regras de entrada. Cada regra é um objeto com rule_number, protocol, action, cidr_block e opcionalmente from_port/to_port (para protocolos não -1)."
  type = list(object({
    rule_number = number
    protocol    = string
    action      = string
    cidr_block  = string
    from_port   = optional(number)
    to_port     = optional(number)
  }))
  default = []
}

variable "outbound_rules" {
  description = "Lista de regras de saída. Mesmo formato das regras de entrada."
  type = list(object({
    rule_number = number
    protocol    = string
    action      = string
    cidr_block  = string
    from_port   = optional(number)
    to_port     = optional(number)
  }))
  default = []
}

variable "tags" {
  description = "Tags a serem aplicadas em todos os recursos"
  type        = map(string)
  default     = {}
}

