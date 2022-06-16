locals {
  application_name = "nodejs-api-aws-terraform-gha"

  default_tags = {
    name        = local.application_name
    url         = var.region
    environment = var.environment
  }

  container_port = "8080"
  memory_limit   = 512
  cpu_limit      = 256

  all_cidr_block = ["0.0.0.0/0"]

  hosted_zone = var.hosted_zone
}