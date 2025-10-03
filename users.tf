// IAM Users declaration

// Github Action configuration for pushing Dockers to ECR repo
resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.github.certificates[0].sha1_fingerprint]
}

resource "aws_iam_role" "github_ecr_role" {
  name               = "GitHubECRPushRole"
  assume_role_policy = data.aws_iam_policy_document.github_assume_role.json
}

resource "aws_iam_policy" "ecr_policy" {
  name        = "GitHubECRPushPolicy"
  description = "Allow GitHub Actions to push/pull images to ECR"
  policy      = data.aws_iam_policy_document.ecr_access.json
}

// Attach policy to the role
resource "aws_iam_role_policy_attachment" "github_ecr_attach" {
  role       = aws_iam_role.github_ecr_role.name
  policy_arn = aws_iam_policy.ecr_policy.arn
}

// Terraform user (able to terraform apply in CI)
resource "aws_iam_user" "terraform" {
  name = "terraform"
}

resource "aws_iam_access_key" "terraform" {
  user = aws_iam_user.terraform.name
}

resource "aws_iam_user_policy_attachment" "terraform_admin_policy" {
  user       = aws_iam_user.terraform.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
