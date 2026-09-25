resource "aws_route_table" "oregan_vpc_public_rt" {
  vpc_id = aws_vpc.oregan_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.oregan_vpc_igw.id
  }

  tags = {
    Name = "oregan_vpc_public_rt"
  }
}

resource "aws_route_table_association" "public_1" {
  subnet_id = aws_subnet.oregan_vpc_public[0].id

  route_table_id = aws_route_table.oregan_vpc_public_rt.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id = aws_subnet.oregan_vpc_public[1].id

  route_table_id = aws_route_table.oregan_vpc_public_rt.id
}


# resource "aws_route_table" "oregan_vpc_private-rt" {
#   vpc_id = aws_vpc.oregan_vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     # nat_gateway_id = aws_nat_gateway.nat_gateway.id
#   }

#   tags = {
#     Name = "oregan_vpc_private-rt"
#   }
# }

# resource "aws_route_table_association" "private_1" {
#   subnet_id = aws_subnet.oregan_vpc_private[0].id

#   route_table_id = aws_route_table.oregan_vpc_private-rt.id
# }

# resource "aws_route_table_association" "private_2" {
#   subnet_id = aws_subnet.oregan_vpc_private[1].id

#   route_table_id = aws_route_table.oregan_vpc_private-rt.id
# }