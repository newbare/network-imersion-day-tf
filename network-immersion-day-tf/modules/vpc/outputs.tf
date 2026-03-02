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
#lab2
# ... (outputs existentes) ...

output "tgw_subnet_ids" {
  description = "IDs das subnets criadas para o Transit Gateway (vazio se nenhuma foi criada)"
  value       = aws_subnet.tgw[*].id
}
