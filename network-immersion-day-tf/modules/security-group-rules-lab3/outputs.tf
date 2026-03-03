# modules/security-group-rules-lab3/outputs.tf

output "ingress_rule_ids" {
  description = "Mapa dos IDs das regras de entrada criadas"
  value = {
    for k, r in aws_vpc_security_group_ingress_rule.this : k => r.id
  }
}

output "egress_rule_ids" {
  description = "Mapa dos IDs das regras de saída criadas"
  value = {
    for k, r in aws_vpc_security_group_egress_rule.this : k => r.id
  }
}
