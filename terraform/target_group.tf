resource "aws_lb_target_group" "target_group" {
  name        = local.application_name
  port        = local.container_port
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "ip"

  health_check {
    enabled             = true
    path                = "/health"
    protocol            = "HTTP"
    port                = local.container_port
    healthy_threshold   = 3
    unhealthy_threshold = 3
    interval            = 10
    matcher             = "200"
    timeout             = 5
  }

  tags = local.default_tags
}