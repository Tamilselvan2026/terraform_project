resource "aws_eip" "eip" {
  domain = "vpc"

  tags = {
    Name = "terraform-nat-eip"
  }
}

# resource "aws_nat_gateway" "nat_gateway" {
#   allocation_id = aws_eip.eip.id

#   subnet_id = aws_subnet.oregan_vpc_public[0].id

#   tags = {
#     Name = "terraform-nat-gateway"
#   }

#   depends_on = [
#     aws_internet_gateway.oregan_vpc_igw
#   ]
# }