resource "aws_iam_role" "wamserver_ecr_readonly" {
  name = "wamserver-ecr-readonly"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "build.apprunner.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "wamserver_ecr_readonly_policy" {
  name = "wamserver-ecr-readonly-policy"
  role = aws_iam_role.wamserver_ecr_readonly.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage"
      ]
      Resource = aws_ecr_repository.wamserver.arn
    }]
  })
}
