# modules/iam-roles/variables.tf

variable "role_name" {
  description = "Nome da IAM Role"
  type        = string
}

variable "instance_profile_name" {
  description = "Nome do Instance Profile"
  type        = string
}

variable "tags" {
  description = "Tags comuns"
  type        = map(string)
  default     = {}
}


variable "private_subnet_cidrs" {
  description = "Lista de todos os CIDRs das subnets privadas (de todas as VPCs)"
  type        = list(string)
  default     = [] # será preenchido no terraform.tfvars
}