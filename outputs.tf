output "wamserver_ecr_arn" {
  description = "ARN of the WAM Server ECR repository."
  value       = aws_ecr_repository.wamserver.arn
}

output "terraform_access_key_id" {
  description = "Access key ID for terraform user."
  value       = aws_iam_access_key.terraform.id
  sensitive   = true
}

output "terraform_secret_access_key" {
  description = "Secret access key for terraform user."
  value       = aws_iam_access_key.terraform.secret
  sensitive   = true
}

output "github_role_arn" {
  value = aws_iam_role.github_ecr_role.arn
}