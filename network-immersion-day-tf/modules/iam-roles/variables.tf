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
