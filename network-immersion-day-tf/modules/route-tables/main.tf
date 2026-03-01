# modules/route-tables/main.tf

# Tabela de rotas pública
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  # Rota para Internet Gateway (se fornecido)
  dynamic "route" {
    for_each = var.igw_id != null ? [1] : []
    content {
      cidr_block = "0.0.0.0/0"
      gateway_id = var.igw_id
    }
  }

  tags = merge(var.tags, {
    Name = var.public_route_table_name
  })
}

# Associações das subnets públicas
resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_ids)

  subnet_id      = var.public_subnet_ids[count.index]
  route_table_id = aws_route_table.public.id
}

# Tabela de rotas privada
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  # Rota para NAT Gateway (se fornecido)
  dynamic "route" {
    for_each = var.nat_gateway_id != null ? [1] : []
    content {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = var.nat_gateway_id
    }
  }

  tags = merge(var.tags, {
    Name = var.private_route_table_name
  })
}

# Associações das subnets privadas
resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_ids)

  subnet_id      = var.private_subnet_ids[count.index]
  route_table_id = aws_route_table.private.id
}
