# modules/tgw-route-tables-lab3/main.tf

resource "aws_ec2_transit_gateway_route_table" "default" {
  transit_gateway_id = var.transit_gateway_id
  tags               = merge(var.tags, { Name = var.default_route_table_name })
}

resource "aws_ec2_transit_gateway_route_table" "shared_services" {
  transit_gateway_id = var.transit_gateway_id
  tags               = merge(var.tags, { Name = var.shared_services_route_table_name })
}