output "project_name" {
  value = var.project_name
}

output "aws_region" {
  value = var.aws_region
}

output "igw_id" {
    value = aws_internet_gateway.internet_gateway
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "pub_sub_nat_1_id" {
  value = aws_subnet.pub_sub_nat_1.id
}
output "pub_sub_nat_2_id" {
  value = aws_subnet.pub_sub_nat_2.id
}
output "priv_sub_web_1_id" {
  value = aws_subnet.priv_sub_web_1.id
}

output "priv_sub_web_2_id" {
  value = aws_subnet.priv_sub_web_2.id
}

output "priv_sub_db_1_id" {
  value = aws_subnet.priv_sub_db_1.id
}

output "private_sub__6b_id" {
    value = aws_subnet.priv_sub_db_2.id 
}
