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

module "nat" {
  source         = "../modules/nat"
  igw_id         = module.vpc.igw_id
  vpc_id         = module.vpc.vpc_id
  pub_sub_nat_1  = module.vpc.pub_sub_nat_1_id
  pub_sub_nat_2  = module.vpc.pub_sub_nat_2_id
  priv_sub_web_1 = module.vpc.priv_sub_web_1_id
  priv_sub_web_2 = module.vpc.priv_sub_web_2_id
  priv_sub_db_1  = module.vpc.priv_sub_db_1_id
  priv_sub_db_2  = module.vpc.priv_sub_db_2_id
}

module "alb" {
  source = "../modules/alb"
  project_name = module.vpc.project_name
  vpc_id = module.vpc.vpc_id
  alb_sec_group_id = module.alb_sec_group.id
  pub_sub_nat_1 = module.vpc.pub_sub_nat_1_id
  pub_sub_nat_2 = module.vpc.pub_sub_nat_2_id
}