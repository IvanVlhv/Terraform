module "vpc" {
  source          = "../modules/vpc"
  aws_region      = var.aws_region
  project_name    = var.project_name
  vpc_cidr        = var.vpc_cidr
  pub_sub_nat_1   = var.pub_sub_nat_1
  pub_sub_nat_2   = var.pub_sub_nat_2
  priv_sub_web_1  = var.priv_sub_web_1
  priv_sub_web_2  = var.priv_sub_web_2
  priv_sub_db_1   = var.priv_sub_db_1
  priv_sub_db_2   = var.priv_sub_db_2
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

module "sec_group" {
  source = "../modules/sec_group"
  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source            = "../modules/alb"
  project_name      = module.vpc.project_name
  vpc_id            = module.vpc.vpc_id
  alb_sec_group_id  = module.sec_group.alb_sec_group_id
  pub_sub_nat_1     = module.vpc.pub_sub_nat_1_id
  pub_sub_nat_2     = module.vpc.pub_sub_nat_2_id
}

module "web" {
  source            = "../modules/web"
  project_name      = module.vpc.project_name
  web_sec_group_id  = module.sec_group.web_sec_group_id
  priv_sub_web_1    = module.vpc.priv_sub_web_1_id
  priv_sub_web_2    = module.vpc.priv_sub_web_2_id
  target_group_arn  = module.alb.target_group_arn
  instance_type     = var.web_instance_type
  key_name          = var.key_name
    user_data         = filebase64("${path.module}/install_snakegame.sh")
}

module "db" {
  source            = "../modules/db"
  project_name      = module.vpc.project_name
  db_username       = var.db_username
  db_password       = var.db_password
  db_sec_group_id   = module.sec_group.db_sec_group_id
  priv_sub_db_1     = module.vpc.priv_sub_db_1_id
  priv_sub_db_2     = module.vpc.priv_sub_db_2_id
}
