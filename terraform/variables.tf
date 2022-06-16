variable "region" {
  description = "Region to deploy application"
  default     = "us-east-1"
}

variable "repository_url" {
  description = "URL to the repository"
  type        = string
}

variable "environment" {
  description = "Name of the environment being deployed"
}

variable "commit_hash" {
  description = "Commit hash being executed"
}

variable "certificate_arn" {
  description = "The ARN of the certificate used by the Load Balancer"
  type        = string
}

variable "hosted_zone" {
  description = "The hosted zone where your Route53 Record will be created"
  type        = string
}

variable "desired_count" {
  description = "Desired number of containers running"
  default     = 1
}