output "target_group_arn" {
 value = aws_lb_target_group.alb_target.arn
}

output "alb_dns" {
  value = aws_lb.alb.dns_name
}

output "alb_zone_id" {
  value = aws_lb.alb.zone_id
}
