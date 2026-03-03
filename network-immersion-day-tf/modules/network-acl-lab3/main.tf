# module/network-acl-lab3/main.tf

# Cria a NACL
resource "aws_network_acl" "this" {
  vpc_id = var.vpc_id
  tags   = merge(var.tags, { Name = var.name })
}

# Regras de entrada
resource "aws_network_acl_rule" "inbound" {
  for_each = {
    for idx, rule in var.inbound_rules :
    "inbound-${rule.rule_number}" => rule
  }

  network_acl_id = aws_network_acl.this.id
  rule_number    = each.value.rule_number
  protocol       = each.value.protocol
  rule_action    = each.value.action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
  egress         = false
}

# Regras de saída
resource "aws_network_acl_rule" "outbound" {
  for_each = {
    for idx, rule in var.outbound_rules :
    "outbound-${rule.rule_number}" => rule
  }

  network_acl_id = aws_network_acl.this.id
  rule_number    = each.value.rule_number
  protocol       = each.value.protocol
  rule_action    = each.value.action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
  egress         = true
}

# Associações com subnets
resource "aws_network_acl_association" "this" {
  count = length(var.subnet_ids)

  network_acl_id = aws_network_acl.this.id
  subnet_id      = var.subnet_ids[count.index]
}
