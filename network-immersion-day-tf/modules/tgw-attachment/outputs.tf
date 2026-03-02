# modules/tgw-attachment/outputs.tf

output "attachment_id" {
  description = "ID do anexo VPC ao Transit Gateway"
  value       = aws_ec2_transit_gateway_vpc_attachment.this.id
}
