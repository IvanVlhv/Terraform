resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = [var.priv_sub_db_1, var.priv_sub_db_2]
}

resource "aws_db_instance" "db" {
  identifier              = "zavrsni-db"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t2.micro"
  allocated_storage       = 20
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids  = [var.db_sec_group_id]
  skip_final_snapshot     = true
}
