# Módulo para criar VPC Endpoints
# Suporta endpoints de interface e gateway

# Endpoint de Interface para KMS
resource "aws_vpc_endpoint" "kms" {
  count             = var.create_legacy_endpoints ? 1 : 0
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
  count             = var.create_legacy_endpoints ? 1 : 0
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = var.route_table_ids

  tags = merge(var.tags, {
    Name = "VPC A S3 Endpoint"
  })
}
# lab2.1
# Endpoints de Interface (para serviços como SSM, KMS, etc.)
resource "aws_vpc_endpoint" "interface" {
  for_each = var.interface_endpoints

  vpc_id              = var.vpc_id
  service_name        = each.value.service_name
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.private_subnet_ids
  security_group_ids  = each.value.security_group_ids != null ? each.value.security_group_ids : var.security_group_ids
  private_dns_enabled = each.value.private_dns_enabled != null ? each.value.private_dns_enabled : var.enable_private_dns

  tags = merge(var.tags, {
    Name = each.value.name
  })
}

# Endpoints de Gateway (para S3 e DynamoDB)
resource "aws_vpc_endpoint" "gateway" {
  for_each = var.gateway_endpoints

  vpc_id            = var.vpc_id
  service_name      = each.value.service_name
  vpc_endpoint_type = "Gateway"
  route_table_ids   = each.value.route_table_ids != null ? each.value.route_table_ids : var.route_table_ids

  tags = merge(var.tags, {
    Name = each.value.name
  })
}
