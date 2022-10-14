resource "aws_lb" "loadbalancer" {
  internal           = "false"
  name               = local.application_name
  load_balancer_type = "application"
  subnets            = module.vpc.public_subnets
  security_groups = [
    aws_security_group.alb_security_group.id
  ]
  tags = local.default_tags
}

resource "aws_lb_listener" "listener_https" {
  default_action {
    target_group_arn = aws_lb_target_group.target_group.arn
    type             = "forward"
  }
  certificate_arn   = var.certificate_arn
  load_balancer_arn = aws_lb.loadbalancer.arn
  port              = "443"
  protocol          = "HTTPS"
}

resource "aws_lb_listener" "http_redirect" {
  // Directing traffic from HTTP to HTTPS to ensure best security practice
  load_balancer_arn = aws_lb.loadbalancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}