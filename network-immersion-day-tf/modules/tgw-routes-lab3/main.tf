# modules/tgw-routes-lab3/main.tf

resource "aws_route" "this" {
  for_each = var.routes

  route_table_id         = each.value.route_table_id
  destination_cidr_block = each.value.destination_cidr_block
  transit_gateway_id     = var.transit_gateway_id
}
