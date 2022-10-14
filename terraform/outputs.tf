output "route53_dns_record" {
  value = "${aws_route53_record.dns_record.name}.${data.aws_route53_zone.dns_zone.name}"
}

output "load_balancer_url" {
  value = aws_lb.loadbalancer.dns_name
}

output "repository_url" {
  value = aws_ecr_repository.repository.repository_url
}