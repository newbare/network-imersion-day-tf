# modules/tgw-route-tables-lab3/outputs.tf

output "default_route_table_id" {
  description = "ID da tabela de rotas padrão"
  value       = aws_ec2_transit_gateway_route_table.default.id
}

output "shared_services_route_table_id" {
  description = "ID da tabela de rotas de serviços compartilhados"
  value       = aws_ec2_transit_gateway_route_table.shared_services.id
}
