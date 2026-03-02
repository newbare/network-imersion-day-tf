# modules/tgw-routes-tables/main.tf
# Adiciona rotas para o Transit Gateway em uma tabela de rotas específica
resource "aws_route" "this" {
  for_each = { for idx, route in var.routes : idx => route }

  route_table_id         = var.route_table_id
  destination_cidr_block = each.value.destination
  transit_gateway_id     = each.value.transit_gateway_id
}
