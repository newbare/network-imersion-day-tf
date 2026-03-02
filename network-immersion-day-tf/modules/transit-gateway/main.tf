# Módulo: transit-gateway

resource "aws_ec2_transit_gateway" "this" {
  description                     = var.description
  amazon_side_asn                 = var.amazon_side_asn
  auto_accept_shared_attachments  = var.auto_accept_shared_attachments
  default_route_table_association = var.default_route_table_association
  default_route_table_propagation = var.default_route_table_propagation
  vpn_ecmp_support                = var.vpn_ecmp_support
  dns_support                     = var.dns_support
  multicast_support               = var.multicast_support

  tags = merge(var.tags, {
    Name = var.name
  })
}
