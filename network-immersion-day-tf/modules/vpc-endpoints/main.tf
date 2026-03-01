# Módulo para criar VPC Endpoints
# Suporta endpoints de interface e gateway

# Endpoint de Interface para KMS
resource "aws_vpc_endpoint" "kms" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.kms"
  vpc_endpoint_type = "Interface"

  subnet_ids          = var.private_subnet_ids
  security_group_ids  = var.security_group_ids
  private_dns_enabled = var.enable_private_dns

  tags = merge(var.tags, {
    Name = "VPC A KMS Endpoint"
  })
}

# Endpoint de Gateway para S3
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = var.route_table_ids

  tags = merge(var.tags, {
    Name = "VPC A S3 Endpoint"
  })
}
