module "vpc" {
  source = "../modules/vpc"
  region = var.region
  project_name = var.project_name
  vpc_cidr = var.vpc_cidr
  public_sub_1a = var.public_sub_1a
  public_sub_2b = var.public_sub_2b
  private_sub_3a = var.private_sub_3a
  private_sub_4b = var.private_sub_4b
  private_sub_5a = var.private_sub_5a
  private_sub_6b = var.private_sub_6b
}


