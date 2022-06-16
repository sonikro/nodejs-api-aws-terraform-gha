terraform {
  extra_arguments "retry_lock" {
    commands  = get_terraform_commands_that_need_locking()
    arguments = ["-lock-timeout=10m"]
  }
}

remote_state {
  backend = "s3"
  config = {
    bucket         = "terragrunt-${get_aws_account_id()}-statefiles"
    key            = "sonikro/nodejs-api-aws-terraform-gha/nodejs-api-aws-terraform-gha.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terragrunt-${get_aws_account_id()}-lockfiles"
    s3_bucket_tags = {
      Name      = "terragrunt-statefiles"
    }
    dynamodb_table_tags = {
      Name      = "terragrunt-lockfiles"
    }
  }
}
