# modules/tgw-propagations-lab3/outputs.tf

output "propagation_ids" {
  description = "Mapa dos IDs das propagações"
  value = {
    for k, p in aws_ec2_transit_gateway_route_table_propagation.this : k => p.id
  }
}
