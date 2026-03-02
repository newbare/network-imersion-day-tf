# Outputs do módulo transit-gateway

output "transit_gateway_id" {
  description = "ID do Transit Gateway"
  value       = aws_ec2_transit_gateway.this.id
}

output "arn" {
  description = "ARN do Transit Gateway"
  value       = aws_ec2_transit_gateway.this.arn
}

output "association_default_route_table_id" {
  description = "ID da tabela de rotas padrão de associação"
  value       = aws_ec2_transit_gateway.this.association_default_route_table_id
}

output "propagation_default_route_table_id" {
  description = "ID da tabela de rotas padrão de propagação"
  value       = aws_ec2_transit_gateway.this.propagation_default_route_table_id
}
