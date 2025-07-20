# create application load balancer
resource "aws_lb" "alb" {
  name                       = "${var.project_name}-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.alb_sec_group_id]
  subnets                    = [var.pub_sub_nat_1,var.pub_sub_nat_2,]
  enable_deletion_protection = true   
  
  tags        = {
      Name    = "${var.project_name}-alb"
  }       
}

# create target group for load balancer
resource "aws_lb_target_group" "alb_target" {
  name     = "${var.project_name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

    health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}

# create listener
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target.arn
  }
}
