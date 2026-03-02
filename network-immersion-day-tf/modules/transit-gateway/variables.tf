# Variáveis de entrada para o módulo transit-gateway

variable "name" {
  description = "Nome do Transit Gateway"
  type        = string
}

variable "description" {
  description = "Descrição do Transit Gateway"
  type        = string
  default     = null
}

variable "amazon_side_asn" {
  description = "Número ASN privado para o TGW (default 64512)"
  type        = number
  default     = 64512
}

variable "auto_accept_shared_attachments" {
  description = "Auto aceitar anexos compartilhados (disable ou enable)"
  type        = string
  default     = "disable"
}

variable "default_route_table_association" {
  description = "Associar automaticamente à tabela de rotas padrão (disable ou enable)"
  type        = string
  default     = "enable"
}

variable "default_route_table_propagation" {
  description = "Propagar automaticamente à tabela de rotas padrão (disable ou enable)"
  type        = string
  default     = "enable"
}

variable "vpn_ecmp_support" {
  description = "Suporte a ECMP para VPN (disable ou enable)"
  type        = string
  default     = "enable"
}

variable "dns_support" {
  description = "Suporte a DNS (disable ou enable)"
  type        = string
  default     = "enable"
}

variable "multicast_support" {
  description = "Suporte a multicast (disable ou enable)"
  type        = string
  default     = "disable"
}

variable "tags" {
  description = "Tags comuns"
  type        = map(string)
  default     = {}
}
