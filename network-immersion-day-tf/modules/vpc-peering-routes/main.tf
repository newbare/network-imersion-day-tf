# modules/vpc-peering-routes/main.tf
resource "aws_route" "this" {
  for_each = var.routes

  route_table_id            = each.value.route_table_id
  destination_cidr_block    = each.value.destination_cidr
  vpc_peering_connection_id = var.peering_connection_id
}
