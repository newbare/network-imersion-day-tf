# module/network-acl-lab3/variables.tf 

output "nacl_id" {
  description = "ID da NACL criada"
  value       = aws_network_acl.this.id
}

output "nacl_arn" {
  description = "ARN da NACL"
  value       = aws_network_acl.this.arn
}
