#vpc
resource "aws_vpc" "vpc" {
    cidr_block              = var.vpc_cidr
    instance_tenancy        = "default"
    enable_dns_hostnames    = true
    enable_dns_support      = true

    tags        = {
        Name    = "${var.project_name}-vpc"
    }    
}

#internet gateway 
resource "aws_internet_gateway" "internet_gateway" {
    vpc_id      = aws_vpc.vpc.id

    tags        = {
        Name    = "${var.project_name}-igw"
    } 
}

#available zones
data "aws_availability_zones" "available_zones" {}

#public subnet pub_sub_nat_1
resource "aws_subnet" "pub_sub_nat_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pub_sub_nat_1
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = true

  tags      = {
    Name    = "pub_sub_nat_1"
  }
}

#public subnet pub_sub_nat_2
resource "aws_subnet" "pub_sub_nat_2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pub_sub_nat_2
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = true

  tags      = {
    Name    = "pub_sub_nat_2"
  }
}

#route table and public route
resource "aws_route_table" "public_route_table" {
  vpc_id       = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags       = {
    Name     = "public_route_table"
  }
}

# connect public subnet pub_sub_nat_1 to public route table
resource "aws_route_table_association" "pb1a_rt_connection" {
  subnet_id           = aws_subnet.pub_sub_nat_1.id
  route_table_id      = aws_route_table.public_route_table.id
}

# connect public subnet pub_sub_nat_2 to public route table
resource "aws_route_table_association" "pb2b_rt_connection" {
  subnet_id           = aws_subnet.pub_sub_nat_2.id
  route_table_id      = aws_route_table.public_route_table.id
}

# private subnet priv_sub_web_1
resource "aws_subnet" "priv_sub_web_1" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.priv_sub_web_1
  availability_zone        = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "priv_sub_web_1"
  }
}

# private subnet priv_sub_web_2
resource "aws_subnet" "priv_sub_web_2" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.priv_sub_web_2
  availability_zone        = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "priv_sub_web_2"
  }
}

# private subnet priv_sub_db_1
resource "aws_subnet" "priv_sub_db_1" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.priv_sub_db_1
  availability_zone        = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "priv_sub_db_1"
  }
}

# private subnet priv_sub_db_2
resource "aws_subnet" "priv_sub_db_2" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.priv_sub_db_2
  availability_zone        = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "priv_sub_db_2"
  }
}
