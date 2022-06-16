data "aws_iam_policy_document" "execution_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "task_policy" {

  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = [
      "arn:aws:logs:*:*:log-group:*:log-stream:*",
      aws_cloudwatch_log_group.log_group.arn,
      "arn:aws:logs:*:*:destination:*"
    ]
  }

  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage"
    ]

    resources = [
      aws_ecr_repository.repository.arn
    ]
  }
}

resource "aws_iam_role" "execution_role" {
  name               = "${local.application_name}-task"
  assume_role_policy = data.aws_iam_policy_document.execution_role_policy.json

  inline_policy {
    name   = "task-policy"
    policy = data.aws_iam_policy_document.task_policy.json
  }

}

resource "aws_iam_role_policy_attachment" "ecs_tasks_execution_role" {
  role       = aws_iam_role.execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}