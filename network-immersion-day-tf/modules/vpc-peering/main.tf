# Módulo: vpc-peering/main.tf

resource "aws_vpc_peering_connection" "this" {
  for_each = var.peering_connections

  vpc_id      = each.value.requester_vpc_id
  peer_vpc_id = each.value.accepter_vpc_id
  auto_accept = true

  tags = merge(var.tags, {
    Name = each.value.name
  })
}
