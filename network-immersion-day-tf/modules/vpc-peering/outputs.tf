# Outputs do módulo vpc-peering

output "peering_ids" {
  description = "Mapa dos IDs das conexões de peering criadas."
  value       = { for k, v in aws_vpc_peering_connection.this : k => v.id }
}
