# modules/tgw-subnets-lab3/outputs.tf
output "subnet_ids" {
  description = "IDs das subnets TGW criadas"
  value       = aws_subnet.this[*].id
}
