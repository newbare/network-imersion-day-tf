# modules/vpc-peering-routes/outputs.tf

# Opcional: pode retornar os IDs das rotas se necessário
output "route_ids" {
  description = "IDs dos recursos de rota criados."
  value       = { for k, v in aws_route.this : k => v.id }
}
