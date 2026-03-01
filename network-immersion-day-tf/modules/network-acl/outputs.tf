# modules/network-acl/outputs.tf

output "network_acl_id" {
  description = "ID da Network ACL criada"
  value       = aws_network_acl.this.id
}
