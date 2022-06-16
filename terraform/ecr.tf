resource "aws_ecr_repository" "repository" {
  name = local.application_name

  tags = local.default_tags
}

resource "aws_ecr_lifecycle_policy" "policy" {
  repository = aws_ecr_repository.repository.id

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than 14 days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 14
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}