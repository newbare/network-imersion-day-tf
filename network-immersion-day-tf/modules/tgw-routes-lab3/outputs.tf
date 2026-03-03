# # modules/tgw-routes-la3/outputs.tf

output "route_ids" {
  description = "Mapa dos IDs das rotas criadas"
  value = {
    for k, r in aws_route.this : k => r.id
  }
}
