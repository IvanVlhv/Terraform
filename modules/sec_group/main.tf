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

resource "aws_vpc_security_group_ingress_rule" "alb_http" {
  security_group_id            = aws_security_group.alb_sec_group.id
  from_port                    = 80
  to_port                      = 80
  ip_protocol                  = "tcp"
  cidr_ipv4                    = "0.0.0.0/0"
  description                  = "Allow HTTP from Internet to ALB"
}

resource "aws_vpc_security_group_ingress_rule" "alb_https" {
  security_group_id            = aws_security_group.alb_sec_group.id
  from_port                    = 443
  to_port                      = 443
  ip_protocol                  = "tcp"
  cidr_ipv4                    = "0.0.0.0/0"
  description                  = "Allow HTTPS from Internet to ALB"
}

resource "aws_vpc_security_group_ingress_rule" "web_http" {
  security_group_id            = aws_security_group.web_sec_group.id
  from_port                    = 80
  to_port                      = 80
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.alb_sec_group.id
  description                  = "Allow HTTP from ALB to Web Servers"
}

resource "aws_vpc_security_group_ingress_rule" "db_mysql" {
  security_group_id            = aws_security_group.db_sec_group.id
  from_port                    = 3306
  to_port                      = 3306
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.web_sec_group.id
  description                  = "Allow MySQL from Web Servers to DB"
}

// Egress rules using aws_vpc_security_group_egress_rule:
resource "aws_vpc_security_group_egress_rule" "alb_egress" {
  security_group_id = aws_security_group.alb_sec_group.id
  from_port         = 0
  to_port           = 0
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow all outbound from ALB"
}

resource "aws_vpc_security_group_egress_rule" "web_egress" {
  security_group_id = aws_security_group.web_sec_group.id
  from_port         = 0
  to_port           = 0
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow all outbound from Web Servers"
}

resource "aws_vpc_security_group_egress_rule" "db_egress" {
  security_group_id = aws_security_group.db_sec_group.id
  from_port         = 0
  to_port           = 0
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow all outbound from DB"
}
