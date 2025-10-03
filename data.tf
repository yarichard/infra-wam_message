// OIDC Provider for GitHub
data "tls_certificate" "github" {
  url = "https://token.actions.githubusercontent.com"
}

// IAM Role for GitHub Actions
data "aws_iam_policy_document" "github_assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    # Must always match
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    # Allow every branch for all projects
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = flatten([
        for repo in var.github_repositories : [
          "repo:yarichard/${repo}:ref:refs/heads/*",
          "repo:yarichard/${repo}:ref:refs/tags/*",
          "repo:yarichard/${repo}:pull_request"
        ]
      ])
    }
  }
}

// Policy for ECR Push/Pull
data "aws_iam_policy_document" "ecr_access" {
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:CompleteLayerUpload",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart",
      "ecr:BatchGetImage"
    ]
    resources = ["*"]
  }
}