resource "aws_internet_gateway" "oregan_vpc_igw" {
  vpc_id = aws_vpc.oregan_vpc.id

  tags = {
    Name = "oregan_vpc-igw"
  }
}