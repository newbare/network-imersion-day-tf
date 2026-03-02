# Outputs do módulo vpc-endpoints
# Outputs para endpoints legados (com count)
output "kms_endpoint_id" {
  description = "ID do endpoint KMS (legado)"
  value       = try(aws_vpc_endpoint.kms[0].id, null)
}

output "kms_endpoint_dns" {
  description = "DNS name do endpoint KMS (legado)"
  value       = try(aws_vpc_endpoint.kms[0].dns_entry[0].dns_name, null)
}

output "s3_endpoint_id" {
  description = "ID do endpoint S3 gateway (legado)"
  value       = try(aws_vpc_endpoint.s3[0].id, null)
}

# Outputs para endpoints dinâmicos (interface e gateway) - já devem existir
output "interface_endpoint_ids" {
  description = "Mapa de IDs dos endpoints de interface"
  value       = { for k, v in aws_vpc_endpoint.interface : k => v.id }
}

output "gateway_endpoint_ids" {
  description = "Mapa de IDs dos endpoints de gateway"
  value       = { for k, v in aws_vpc_endpoint.gateway : k => v.id }
}

# (Opcional) Output consolidado para todos os endpoints
output "all_endpoint_ids" {
  description = "Todos os IDs de endpoints criados"
  value = merge(
    { for k, v in aws_vpc_endpoint.interface : "interface_${k}" => v.id },
    { for k, v in aws_vpc_endpoint.gateway : "gateway_${k}" => v.id },
    try({ kms = aws_vpc_endpoint.kms[0].id }, {}),
    try({ s3 = aws_vpc_endpoint.s3[0].id }, {})
  )
}
