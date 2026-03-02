# Variáveis de entrada para o módulo ec2-instance

# Nome da instância (tag Name)
variable "name" {
  description = "Nome da instância (tag Name)"
  type        = string
}

# ID da AMI a ser utilizada
variable "ami" {
  description = "ID da AMI para a instância"
  type        = string
}

# Tipo da instância EC2 (ex: t2.micro)
variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
}

# ID da subnet onde a instância será lançada
variable "subnet_id" {
  description = "ID da subnet"
  type        = string
}

# IP privado fixo (opcional)
variable "private_ip" {
  description = "IP privado fixo (opcional)"
  type        = string
  default     = null
}

# Lista de security groups (por ID)
variable "vpc_security_group_ids" {
  description = "Lista de IDs de security groups"
  type        = list(string)
}

# Nome do instance profile IAM (opcional)
variable "iam_instance_profile" {
  description = "Nome do instance profile IAM (opcional)"
  type        = string
  default     = null
}

# Script de user data (opcional)
variable "user_data" {
  description = "Script de inicialização (user data)"
  type        = string
  default     = null
}

# Nome do key pair para acesso SSH (opcional)
variable "key_name" {
  description = "Nome do key pair para acesso SSH (opcional)"
  type        = string
  default     = null
}

# Associar IP público automaticamente (usado para subnets públicas)
variable "associate_public_ip" {
  description = "Se deve associar um IP público automaticamente"
  type        = bool
  default     = false
}

# Tags adicionais
variable "tags" {
  description = "Tags adicionais (a tag Name é definida separadamente)"
  type        = map(string)
  default     = {}
}
