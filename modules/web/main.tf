#this part fetches latest amazon linux ami
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp3"]
  }
}

#this part creates two web instances
resource "aws_instance" "web_1" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = var.priv_sub_web_1
  vpc_security_group_ids = [var.web_sec_group_id]
  key_name               = var.key_name
  user_data              = var.user_data

  tags = {
    Name = "${var.project_name}-web-1"
  }
}

resource "aws_instance" "web_2" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = var.priv_sub_web_2
  vpc_security_group_ids = [var.web_sec_group_id]
  key_name               = var.key_name
  user_data              = var.user_data

  tags = {
    Name = "${var.project_name}-web-2"
  }
}
