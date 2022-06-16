resource "aws_security_group" "alb_security_group" {
  name        = "${local.application_name}-alb-security-group"
  vpc_id      = module.vpc.vpc_id
  tags        = local.default_tags
  description = "Load Balancer SG for ${local.application_name}"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "alb_ingress_rule_http" {
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.alb_security_group.id
  type              = "ingress"
  cidr_blocks       = local.all_cidr_block
  description       = "Allowed ingress cidr for ${local.application_name}"
}

resource "aws_security_group_rule" "alb_ingress_rule" {
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.alb_security_group.id
  type              = "ingress"
  cidr_blocks       = local.all_cidr_block
  description       = "Allowed ingress cidr for ${local.application_name}"
}

resource "aws_security_group_rule" "alb_egress_rule" {
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.alb_security_group.id
  type              = "egress"
  cidr_blocks       = local.all_cidr_block
  description       = "Allowed egress cidr for ${local.application_name}"
}

resource "aws_security_group" "private_security_group" {
  name        = "${local.application_name}-private-security-group"
  vpc_id      = module.vpc.vpc_id
  description = "A security group to allow HTTP traffic from the public security group (load balancers) to the services"
  tags        = local.default_tags

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    security_groups = [
      aws_security_group.alb_security_group.id
    ]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = local.all_cidr_block
  }

  lifecycle {
    create_before_destroy = true
  }
}