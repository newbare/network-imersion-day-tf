# Pode ficar vazio ou retornar os IDs das rotas se necessário
output "route_ids" {
  value = { for k, v in aws_route.this : k => v.id }
}
