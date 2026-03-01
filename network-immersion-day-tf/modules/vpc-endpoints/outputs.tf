# Outputs do módulo vpc-endpoints

output "kms_endpoint_id" {
  value = aws_vpc_endpoint.kms.id
}

output "kms_endpoint_dns" {
  value = aws_vpc_endpoint.kms.dns_entry[0].dns_name
}

output "s3_endpoint_id" {
  value = aws_vpc_endpoint.s3.id
}
