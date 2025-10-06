output "wamserver_ecr_arn" {
  description = "ARN of the WAM Server ECR repository."
  value       = aws_ecr_repository.wamserver.arn
}

output "github_role_arn" {
  value = aws_iam_role.github_ecr_role.arn
}