resource "aws_subnet" "oregan_vpc_public" {
  count = length(var.public_subnet_cidrs)

  vpc_id = aws_vpc.oregan_vpc.id

  cidr_block = var.public_subnet_cidrs[count.index]

  availability_zone = var.availability_zones[count.index]

  map_public_ip_on_launch = true

  tags = {
    Name = "oregan_vpc_public-${count.index + 1}"
  }
}

resource "aws_subnet" "oregan_vpc_private" {
  count = length(var.private_subnet_cidrs)

  vpc_id = aws_vpc.oregan_vpc.id

  cidr_block = var.private_subnet_cidrs[count.index]

  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "oregan_vpc_private-${count.index + 1}"
  }
}