# modules/internet-gateway/variables.tf

variable "vpc_id" {
  description = "ID da VPC à qual o Internet Gateway será anexado"
  type        = string
}

variable "name" {
  description = "Nome do Internet Gateway"
  type        = string
}

variable "tags" {
  description = "Tags adicionais"
  type        = map(string)
  default     = {}
}
