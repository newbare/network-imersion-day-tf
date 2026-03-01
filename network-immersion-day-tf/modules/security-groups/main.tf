# Módulo: security-groups

# modules/security-groups/main.tf

# Security Group público (para instância pública) - permite ICMP do IP configurado
resource "aws_security_group" "public" {
  name        = var.public_sg_name
  description = var.public_sg_description
  vpc_id      = var.vpc_id

  ingress {
    description = "ICMP do meu IP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.my_ip_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = var.public_sg_name
  })
}

# Security Group privado (para instância privada) - permite ICMP apenas do SG público
resource "aws_security_group" "private" {
  name        = var.private_sg_name
  description = var.private_sg_description
  vpc_id      = var.vpc_id

  ingress {
    description     = "ICMP do SG público"
    from_port       = -1
    to_port         = -1
    protocol        = "icmp"
    security_groups = [aws_security_group.public.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = var.private_sg_name
  })
}

# Security Group para o endpoint KMS (permite HTTPS das subnets privadas)
resource "aws_security_group" "kms_endpoint" {
  name        = "VPC A KMS Endpoint SG"
  description = "Allow HTTPS from private subnets to KMS endpoint"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTPS from private subnets"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.private_subnet_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "VPC A KMS Endpoint SG"
  })
}
