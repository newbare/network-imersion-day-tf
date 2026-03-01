# modules/network-acl/variables.tf

variable "vpc_id" {
  description = "ID da VPC onde a NACL será criada"
  type        = string
}

variable "subnet_ids" {
  description = "Lista de IDs das subnets que serão associadas à NACL"
  type        = list(string)
}

variable "name" {
  description = "Nome da NACL (usado na tag Name)"
  type        = string
}

variable "inbound_rules" {
  description = <<-EOT
    Lista de regras de entrada (ingress). Cada regra é um objeto com:
    - rule_no: número da regra (ordem de avaliação)
    - protocol: protocolo (ex: "-1" para todos, "tcp", "udp", "icmp")
    - action: "allow" ou "deny"
    - cidr_block: bloco CIDR de origem
    - from_port: porta inicial (0 para todos)
    - to_port: porta final (0 para todos)
  EOT
  type = list(object({
    rule_no    = number
    protocol   = string
    action     = string
    cidr_block = string
    from_port  = number
    to_port    = number
  }))
  default = [
    {
      rule_no    = 100
      protocol   = "-1"
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0
    }
  ]
}

variable "outbound_rules" {
  description = "Lista de regras de saída (egress). Mesmo formato das regras de entrada."
  type = list(object({
    rule_no    = number
    protocol   = string
    action     = string
    cidr_block = string
    from_port  = number
    to_port    = number
  }))
  default = [
    {
      rule_no    = 100
      protocol   = "-1"
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0
    }
  ]
}

variable "tags" {
  description = "Tags adicionais para a NACL"
  type        = map(string)
  default     = {}
}
