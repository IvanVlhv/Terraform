resource "aws_route53_zone" "zone" {
  name = var.domain_name
}

resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.zone.zone_id
  name    = var.domain_name
  type    = "A"
  alias {
    name                   = var.alb_dns
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "additional" {
  count   = var.additional_domain_name != null && var.additional_domain_name != "" ? 1 : 0
  zone_id = aws_route53_zone.zone.zone_id
  name    = var.additional_domain_name
  type    = "A"
  alias {
    name                   = var.alb_dns
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}