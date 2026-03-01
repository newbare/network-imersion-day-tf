# Outputs do módulo security-groups

# modules/security-groups/outputs.tf

output "public_sg_id" {
  description = "ID do security group público"
  value       = aws_security_group.public.id
}

output "private_sg_id" {
  description = "ID do security group privado"
  value       = aws_security_group.private.id
}

output "kms_endpoint_sg_id" {
  description = "ID do security group para o endpoint KMS"
  value       = aws_security_group.kms_endpoint.id
}
