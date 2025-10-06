variable "region" {
  description = "Default region for resources."
  type        = string
  default     = "eu-west-3"
}

variable "wamserver_ecr_repo" {
  description = "Repo for wamserver app"
  type        = string
  default     = "wamserver"
}

variable "aws_account_id" {
  description = "AWS Account ID for ECR image URI."
  type        = string
  default     = "704496393752"
}

variable "github_repositories" {
  description = "List of GitHub repositories allowed for OIDC."
  type        = list(string)
  default     = ["wamserver", "wam_message_gatling"]
}

variable "terraform_repo" {
  description = "GitHub repository name for Terraform state access."
  type        = string
  default     = "infra-wam_message"
}