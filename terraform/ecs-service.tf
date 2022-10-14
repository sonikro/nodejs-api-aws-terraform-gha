resource "aws_ecs_service" "service" {
  cluster               = aws_ecs_cluster.cluster.id
  desired_count         = var.desired_count
  launch_type           = "FARGATE"
  name                  = local.application_name
  task_definition       = aws_ecs_task_definition.task_definition.arn
  force_new_deployment  = true
  wait_for_steady_state = true
  load_balancer {
    container_name   = local.application_name
    container_port   = local.container_port
    target_group_arn = aws_lb_target_group.target_group.arn
  }
  network_configuration {
    security_groups = [
      aws_security_group.private_security_group.id
    ]
    subnets = module.vpc.private_subnets
  }
  depends_on = [
    aws_lb_listener.listener_https
  ]

  tags = local.default_tags
}