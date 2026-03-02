# modules/tgw-attachment/variables.tf

variable "name" {
  description = "Nome do attachment (tag Name)"
  type        = string
}

variable "transit_gateway_id" {
  description = "ID do Transit Gateway"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC a ser anexada"
  type        = string
}

variable "subnet_ids" {
  description = "Lista de IDs das subnets (duas, uma por AZ)"
  type        = list(string)
}

variable "tags" {
  description = "Tags comuns"
  type        = map(string)
  default     = {}
}
