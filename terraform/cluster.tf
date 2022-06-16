resource "aws_ecs_cluster" "cluster" {
  name = local.application_name

  tags = local.default_tags
}