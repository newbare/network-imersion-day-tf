# modules/nat-gateway/main.tf

resource "aws_eip" "this" {
  domain = "vpc"

  tags = merge(var.tags, {
    Name = "${var.name}-eip"
  })
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = var.subnet_id

  tags = merge(var.tags, {
    Name = var.name
  })

  depends_on = [aws_eip.this]
}
