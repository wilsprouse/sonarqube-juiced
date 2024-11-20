resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr_blocks)

  cidr_block = var.public_subnet_cidr_blocks[count.index]
  vpc_id     = aws_vpc.main.id
  availability_zone = element(var.availability_zones, count.index)

  map_public_ip_on_launch = true

  tags = merge (
    {Name = "${var.project-name}-public-${var.availability_zones[count.index]}"
    }
  )
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr_blocks)

  cidr_block = var.private_subnet_cidr_blocks[count.index]
  vpc_id     = aws_vpc.main.id
  availability_zone =element(var.availability_zones, count.index)

  tags = merge (
    {Name = "${var.project-name}-private-${var.availability_zones[count.index]}"}
  )
}
