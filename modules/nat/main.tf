# eip-nat in public subnet 1
resource "aws_eip" "eip_nat_1" {
  tags = {
    Name = "eip_nat_1"
  }
}

# eip-nat in public subnet 2
resource "aws_eip" "eip_nat_2" {
  tags = {
    Name = "eip_nat_2"
  }
}

# nat gateway in public subnet 1
resource "aws_nat_gateway" "nat_1" {
  allocation_id = aws_eip.eip_nat_1.id
  subnet_id     = var.pub_sub_nat_1
  tags   = {
    Name = "nat-1"
  }
    depends_on = [var.igw_id]
}

# nat gateway in public subnet 2
resource "aws_nat_gateway" "nat_2" {
  allocation_id = aws_eip.eip_nat_2.id
  subnet_id     = var.pub_sub_nat_2
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

# private network for priv_sub_web_1 with route table 1
resource "aws_route_table_association" "priv_sub_web_1_rt" {
  subnet_id         = var.priv_sub_web_1
  route_table_id    = aws_route_table.private_rt_1.id
}

# private network for priv_sub_web_2 with route table 1
resource "aws_route_table_association" "priv_sub_web_2_rt" {
  subnet_id         = var.priv_sub_web_2
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

# private network for priv_sub_db_1 with route table 2
resource "aws_route_table_association" "priv_sub_db_1_rt" {
  subnet_id         = var.priv_sub_db_1
  route_table_id    = aws_route_table.private_rt_2.id
}

# private network for priv_sub_db_2 with route table 2
resource "aws_route_table_association" "priv_sub_db_2_rt" {
  subnet_id         = var.priv_sub_db_2
  route_table_id    = aws_route_table.private_rt_2.id
}