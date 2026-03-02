variable "environment" {
  description = "Ambiente (dev, stage, prod)"
  type        = string
}

variable "region" {
  description = "Região AWS"
  type        = string
  default     = "us-east-1"
}

variable "availability_zones" {
  description = "Lista de zonas de disponibilidade"
  type        = list(string)
}

variable "vpc_a_cidr" {
  description = "CIDR da VPC A"
  type        = string
}

variable "vpc_b_cidr" {
  description = "CIDR da VPC B"
  type        = string
}

variable "vpc_c_cidr" {
  description = "CIDR da VPC C"
  type        = string
}

variable "vpc_a_public_subnet_cidrs" {
  description = "Lista de CIDRs para subnets públicas da VPC A"
  type        = list(string)
}

variable "vpc_a_private_subnet_cidrs" {
  description = "Lista de CIDRs para subnets privadas da VPC A"
  type        = list(string)
}

variable "vpc_b_public_subnet_cidrs" {
  description = "Lista de CIDRs para subnets públicas da VPC B"
  type        = list(string)
}

variable "vpc_b_private_subnet_cidrs" {
  description = "Lista de CIDRs para subnets privadas da VPC B"
  type        = list(string)
}

variable "vpc_c_public_subnet_cidrs" {
  description = "Lista de CIDRs para subnets públicas da VPC C"
  type        = list(string)
}

variable "vpc_c_private_subnet_cidrs" {
  description = "Lista de CIDRs para subnets privadas da VPC C"
  type        = list(string)
}

variable "vpc_a_test_instance_ip" {
  description = "IP privado da instância de teste na VPC A"
  type        = string
}

variable "vpc_b_test_instance_ip" {
  description = "IP privado da instância de teste na VPC B"
  type        = string
}

variable "vpc_c_test_instance_ip" {
  description = "IP privado da instância de teste na VPC C"
  type        = string
}

variable "iam_role_name" {
  description = "Nome da IAM Role"
  type        = string
}

variable "iam_instance_profile_name" {
  description = "Nome do Instance Profile"
  type        = string
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t2.micro"
}

variable "tags" {
  description = "Tags adicionais"
  type        = map(string)
  default     = {}
}

# variable "private_subnet_cidrs" {
#   description = "Lista de todos os CIDRs das subnets privadas (de todas as VPCs)"
#   type        = list(string)
#   default     = [] # será preenchido no terraform.tfvars
# }
