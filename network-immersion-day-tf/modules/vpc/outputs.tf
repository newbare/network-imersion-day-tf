# modules/vpc/outputs.tf

output "vpc_id" {
  description = "ID da VPC criada"
  value       = aws_vpc.this.id
}

output "vpc_cidr" {
  description = "Bloco CIDR da VPC"
  value       = aws_vpc.this.cidr_block
}

output "vpc_name" {
  description = "Nome da VPC"
  value       = var.name
}
