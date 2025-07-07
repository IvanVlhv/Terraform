# nat gateway in public subnet 1
resource "aws_eip" "eip_nat_1" {
  vpc = true
  tags = {
    Name = "eip_nat_1"
  }
}

# nat gateway in public subnet 2
resource "aws_eip" "eip_nat_2" {
  vpc = true
  tags = {
    Name = "eip_nat_2"
  }
}

# nat gateway in public subnet 1
resource "aws_nat_gateway" "nat_1" {
  allocation_id = aws_eip.eip_nat_1.id
  subnet_id     = var.public_sub_1a
  tags   = {
    Name = "nat-1"
  }
    depends_on = [var.igw_id]
}

# nat gateway in public subnet 2
resource "aws_nat_gateway" "nat_2" {
  allocation_id = aws_eip.eip_nat_2.id
  subnet_id     = var.public_sub_2b
  tags   = {
    Name = "nat-2"
  }
    depends_on = [var.igw_id]
}

# private route table 1
resource "aws_route_table" "private_rt_1" {
  vpc_id            = var.vpc_id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat_1.id
  }
  tags   = {
    Name = "private_rt_1"
  }
}

# private network for private 3a with route table 1
resource "aws_route_table_association" "private_3a_with_rt" {
  subnet_id         = var.private_sub_3a
  route_table_id    = aws_route_table.private_rt_1.id
}

# private network for private 4b with route table 1
resource "aws_route_table_association" "private_4b_with_rt" {
  subnet_id         = var.private_sub_4b
  route_table_id    = aws_route_table.private_rt_1.id
}

# private route table 2
resource "aws_route_table" "private_rt_2" {
  vpc_id            = var.vpc_id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat_2.id
  }
  tags   = {
    Name = "private_rt_2"
  }
}

# private network for private 5a with route table 2
resource "aws_route_table_association" "private_5a_with_rt" {
  subnet_id         = var.private_sub_5a
  route_table_id    = aws_route_table.private_rt_2.id
}

# private network for private 6b with route table 2
resource "aws_route_table_association" "private_6b_with_rt" {
  subnet_id         = var.private_sub_6b
  route_table_id    = aws_route_table.private_rt_2.id
}