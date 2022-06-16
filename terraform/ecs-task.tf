data "template_file" "task_definition_json" {
  template = file("taskDefinition.json")
  vars = {
    awslogs_group         = aws_cloudwatch_log_group.log_group.name
    environment           = var.environment
    name                  = local.application_name
    region                = var.region
    awslogs_stream_prefix = local.application_name
    image                 = lower("${aws_ecr_repository.repository.repository_url}:${var.commit_hash}")
    container_port        = local.container_port
    memory                = local.memory_limit
    cpu                   = local.cpu_limit
  }
}


resource "aws_ecs_task_definition" "task_definition" {
  family                = local.application_name
  container_definitions = data.template_file.task_definition_json.rendered
  requires_compatibilities = [
    "FARGATE"
  ]
  network_mode       = "awsvpc"
  memory             = local.memory_limit
  cpu                = local.cpu_limit
  tags               = local.default_tags
  execution_role_arn = aws_iam_role.execution_role.arn
}