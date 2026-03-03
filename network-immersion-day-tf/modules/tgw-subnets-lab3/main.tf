# modules/tgw-subnets-lab3/main.tf
resource "aws_subnet" "this" {
  count = length(var.subnet_cidrs)

  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = merge(var.tags, {
    Name = try(var.subnet_names[count.index], "tgw-subnet-${var.availability_zones[count.index]}")
  })
}
