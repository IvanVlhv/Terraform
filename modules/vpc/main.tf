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

#public subnet public_sub_1a
resource "aws_subnet" "public_sub_1a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_sub_1a
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = true

  tags      = {
    Name    = "public_sub_1a"
  }
}

#public subnet public_sub_2b
resource "aws_subnet" "public_sub_2b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_sub_2b
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = true

  tags      = {
    Name    = "public_sub_2b"
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

# connect public subnet public_sub_1a to public route table
resource "aws_route_table_association" "pb1a_rt_connection" {
  subnet_id           = aws_subnet.public_sub_1a.id
  route_table_id      = aws_route_table.public_route_table.id
}

# connect public subnet public_sub_1a to public route table
resource "aws_route_table_association" "pb2b_rt_connection" {
  subnet_id           = aws_subnet.public_sub_2b.id
  route_table_id      = aws_route_table.public_route_table.id
}

# private subnet private_sub_3a
resource "aws_subnet" "private_sub_3a" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.private_sub_3a
  availability_zone        = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "private_sub_3a"
  }
}

# private subnet private_sub_4b
resource "aws_subnet" "private_sub_4b" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.private_sub_4b
  availability_zone        = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "private_sub_4b"
  }
}

# private subnet private_sub_5a
resource "aws_subnet" "private_sub_5a" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.private_sub_5a
  availability_zone        = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "private_sub_5a"
  }
}

# private subnet private_sub_6b
resource "aws_subnet" "private_sub_6b" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.private_sub_6b
  availability_zone        = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "private_sub_6b"
  }
}