resource "aws_cloudwatch_log_group" "log_group" {
  name = "ecs-logs-${local.application_name}"
  tags = local.default_tags
}