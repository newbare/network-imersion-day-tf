# modules/internet-gateway/outputs.tf

output "igw_id" {
  description = "ID do Internet Gateway criado"
  value       = aws_internet_gateway.this.id
}
