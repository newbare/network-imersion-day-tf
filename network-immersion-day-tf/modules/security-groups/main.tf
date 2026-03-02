# Módulo: security-groups
# modules/security-groups/main.tf

# Security Group público (para instância pública) - sem regras inline
resource "aws_security_group" "public" {
  name        = var.public_sg_name
  description = var.public_sg_description
  vpc_id      = var.vpc_id

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

# Security Group privado (para instância privada) - sem regras inline
resource "aws_security_group" "private" {
  name        = var.private_sg_name
  description = var.private_sg_description
  vpc_id      = var.vpc_id

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

# ─────────────────────────────────────────────────────────────────
# Regras de ICMP entre os grupos (usando recursos separados)
# ─────────────────────────────────────────────────────────────────

# Regra 1: Grupo público permite ICMP vindo do grupo privado
resource "aws_security_group_rule" "public_ingress_from_private" {
  type                     = "ingress"
  from_port                = -1
  to_port                  = -1
  protocol                 = "icmp"
  security_group_id        = aws_security_group.public.id
  source_security_group_id = aws_security_group.private.id
  description              = "ICMP do security group privado"
}

# Regra 2: Grupo privado permite ICMP vindo do grupo público
resource "aws_security_group_rule" "private_ingress_from_public" {
  type                     = "ingress"
  from_port                = -1
  to_port                  = -1
  protocol                 = "icmp"
  security_group_id        = aws_security_group.private.id
  source_security_group_id = aws_security_group.public.id
  description              = "ICMP do security group publico"
}

# (Opcional) Regra para permitir ICMP do seu IP externo na instância pública
resource "aws_security_group_rule" "public_ingress_from_my_ip" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  security_group_id = aws_security_group.public.id
  cidr_blocks       = [var.my_ip_cidr]
  description       = "ICMP do meu IP"
}

