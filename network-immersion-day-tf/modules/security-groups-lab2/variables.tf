# modules/security-groups-lab2/variables.tf

variable "name" {
  description = "Nome do security group"
  type        = string
}

variable "description" {
  description = "Descrição do security group"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "ingress_rules" {
  description = "Lista de regras de entrada. Cada regra contém from_port, to_port, protocol, cidr_blocks (lista) e description."
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = []
}

variable "egress_rules" {
  description = "Lista de regras de saída. Padrão permite todo tráfego."
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic"
    }
  ]
}

variable "tags" {
  description = "Tags adicionais"
  type        = map(string)
  default     = {}
}
