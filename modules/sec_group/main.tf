#sec groups
resource "aws_security_group" "alb_sec_group" {
  name      = "alb_security_group"
  vpc_id =  var.vpc_id  
}

resource "aws_security_group" "web_sec_group" {
  name        = "web_security_group"
  vpc_id      = var.vpc_id
}

resource "aws_security_group" "db_sec_group" {
  name        = "db_security_group"
  vpc_id      = var.vpc_id
}

# alb ingress rules
resource "aws_vpc_security_group_ingress_rule" "alb_http" {
  
}