# modules/route-tables/variables.tf

variable "vpc_id" {
  description = "ID da VPC onde as tabelas de rota serão criadas"
  type        = string
}

variable "public_subnet_ids" {
  description = "Lista de IDs das subnets públicas"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Lista de IDs das subnets privadas"
  type        = list(string)
}

variable "igw_id" {
  description = "ID do Internet Gateway para a rota pública (opcional)"
  type        = string
  default     = null
}

variable "nat_gateway_id" {
  description = "ID do NAT Gateway para a rota privada (opcional)"
  type        = string
  default     = null
}

variable "public_route_table_name" {
  description = "Nome da tabela de rotas pública"
  type        = string
  default     = "Public Route Table"
}

variable "private_route_table_name" {
  description = "Nome da tabela de rotas privada"
  type        = string
  default     = "Private Route Table"
}

variable "tags" {
  description = "Tags adicionais para as tabelas de rota"
  type        = map(string)
  default     = {}
}
