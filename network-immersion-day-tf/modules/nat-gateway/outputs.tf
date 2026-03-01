# modules/nat-gateway/outputs.tf

output "nat_gateway_id" {
  description = "ID do NAT Gateway"
  value       = aws_nat_gateway.this.id
}

output "eip_id" {
  description = "ID do Elastic IP associado"
  value       = aws_eip.this.id
}

output "eip_public_ip" {
  description = "Endereço IP público do Elastic IP"
  value       = aws_eip.this.public_ip
}