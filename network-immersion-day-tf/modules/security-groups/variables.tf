# Variáveis de entrada para o módulo security-groups

# modules/security-groups/variables.tf

variable "vpc_id" {
  description = "ID da VPC onde os security groups serão criados"
  type        = string
}

variable "my_ip_cidr" {
  description = "Seu endereço IP público no formato CIDR (ex: 187.23.45.67/32)"
  type        = string
}

variable "public_sg_name" {
  description = "Nome do security group público"
  type        = string
  default     = "VPC A Security Group Public"
}

variable "public_sg_description" {
  description = "Descrição do security group público"
  type        = string
  default     = "Permite ICMP do IP local configurado"
}

variable "private_sg_name" {
  description = "Nome do security group privado"
  type        = string
  default     = "VPC A Security Group Private"
}

variable "private_sg_description" {
  description = "Descrição do security group privado"
  type        = string
  default     = "Permite ICMP apenas da instância pública"
}

variable "tags" {
  description = "Tags comuns para os security groups"
  type        = map(string)
  default     = {}
}

variable "private_subnet_cidrs" {
  description = "Lista de CIDRs das subnets privadas para permitir acesso ao endpoint KMS"
  type        = list(string)
}
