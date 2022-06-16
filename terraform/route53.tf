data "aws_route53_zone" "dns_zone" {
  name         = local.hosted_zone
  private_zone = false
}

resource "aws_route53_record" "dns_record" {
  zone_id = data.aws_route53_zone.dns_zone.zone_id
  name    = local.application_name
  type    = "A"

  alias {
    evaluate_target_health = false
    name                   = aws_lb.loadbalancer.dns_name
    zone_id                = aws_lb.loadbalancer.zone_id
  }
}