# modules/vpc/main.tf

resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = merge(var.tags, {
    Name = var.name
  })
}
#lab2
# Subnets para Transit Gateway (opcional)
resource "aws_subnet" "tgw" {
  count = length(var.tgw_subnet_cidrs)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.tgw_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = merge(var.tags, {
    Name = try(var.tgw_subnet_names[count.index], "${var.name}-tgw-${var.availability_zones[count.index]}")
  })
}
