# modules/tgw-associations-lab3/outputs.tf

output "association_ids" {
  description = "Mapa dos IDs das associações"
  value = {
    for k, a in aws_ec2_transit_gateway_route_table_association.this : k => a.id
  }
}
