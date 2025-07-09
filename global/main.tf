module "vpc" {
  source = "../modules/vpc"
  aws_region = var.aws_region
  project_name = var.project_name
  vpc_cidr = var.vpc_cidr
  pub_sub_nat_1 = var.pub_sub_nat_1
  pub_sub_nat_2 = var.pub_sub_nat_2
  priv_sub_web_1 = var.priv_sub_web_1
  priv_sub_web_2 = var.priv_sub_web_2
  priv_sub_db_1 = var.priv_sub_db_1
  priv_sub_db_2 = var.priv_sub_db_2
}


