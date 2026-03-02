# Módulo: ec2-instance

resource "aws_instance" "this" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  private_ip             = var.private_ip
  vpc_security_group_ids = var.vpc_security_group_ids
  iam_instance_profile   = var.iam_instance_profile
  user_data              = var.user_data
  key_name               = var.key_name # opcional, se quiser usar chave SSH

  # Habilita a atribuição de IP público apenas se solicitado (para subnets públicas)
  associate_public_ip_address = var.associate_public_ip

  tags = merge(var.tags, {
    Name = var.name
  })
}
