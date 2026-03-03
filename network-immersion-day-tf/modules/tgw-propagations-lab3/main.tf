# modules/tgw-propagations-lab3/main.tf

resource "aws_ec2_transit_gateway_route_table_propagation" "this" {
  for_each = var.propagations

  transit_gateway_attachment_id  = each.value.attachment_id
  transit_gateway_route_table_id = each.value.route_table_id
}