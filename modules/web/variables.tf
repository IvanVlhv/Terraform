variable "project_name" {}
variable "web_sec_group_id" {}
variable "priv_sub_web_1" {}
variable "priv_sub_web_2" {}
variable "target_group_arn" {}
variable "instance_type" {}
variable "key_name" { default = null }
variable "user_data" { default = null }
variable "min_size" { default = 1 }
variable "max_size" { default = 3 }
variable "desired_capacity" { default = 2 }
variable "cpu_target" { default = 50 }
