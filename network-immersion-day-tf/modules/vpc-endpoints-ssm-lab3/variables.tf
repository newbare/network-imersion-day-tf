# module/vpc-endpoints-ssm-lab3/main.tf

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "region" {
  description = "Região AWS"
  type        = string
}

variable "subnet_ids" {
  description = "IDs das subnets privadas onde os endpoints serão criados"
  type        = list(string)
}

variable "security_group_ids" {
  description = "IDs dos security groups que permitirão acesso HTTPS aos endpoints"
  type        = list(string)
}

variable "name_prefix" {
  description = "Prefixo para nomear os endpoints"
  type        = string
}

variable "tags" {
  description = "Tags comuns"
  type        = map(string)
  default     = {}
}
