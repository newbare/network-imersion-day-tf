# Outputs do módulo ec2-instance

# ID da instância
output "id" {
  description = "ID da instância EC2"
  value       = aws_instance.this.id
}

# IP público (se houver)
output "public_ip" {
  description = "Endereço IP público da instância (se aplicável)"
  value       = aws_instance.this.public_ip
}

# IP privado
output "private_ip" {
  description = "Endereço IP privado da instância"
  value       = aws_instance.this.private_ip
}

# ARN da instância
output "arn" {
  description = "ARN da instância EC2"
  value       = aws_instance.this.arn
}
