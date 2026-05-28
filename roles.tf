module "ecr_app" {
  source = "git::https://github.com/yarichard/terraform-bootstrap.git//modules/ecr-app?ref=main"

  app_name                 = "wam-message"
  github_repositories      = var.github_repositories
  github_oidc_provider_arn = data.terraform_remote_state.bootstrap-tfstate.outputs.github_oidc_provider_arn
  ecr_push_pull_policy_arn = data.terraform_remote_state.bootstrap-tfstate.outputs.ecr_push_pull_policy_arn
}

// IAM Policy for Terraform State Access
data "aws_iam_policy_document" "terraform_state" {

  statement {
    actions = [
      "ecr:DescribeRepositories",
      "ecr:ListTagsForResource",
      "ecr:CreateRepository"
    ]
    resources = [
      "arn:aws:ecr:${var.region}:${var.aws_account_id}:repository/wamserver"
    ]
  }

  statement {
    actions = [
      "iam:GetRole",
      "iam:ListRolePolicies",
      "iam:ListAttachedRolePolicies",
      "iam:CreateRole",
      "iam:AttachRolePolicy"
    ]
    resources = [
      "arn:aws:iam::${var.aws_account_id}:role/WamMessageAppRunnerECRRole"
    ]
  }

  statement {
    actions = [
      "iam:GetRole",
      "iam:ListRolePolicies",
      "iam:ListAttachedRolePolicies",
      "iam:CreateRole",
      "iam:AttachRolePolicy"
    ]
    resources = [
      "arn:aws:iam::${var.aws_account_id}:role/GitHubActionECRPushRoleForWamMessage"
    ]
  }

  statement {
    actions = [
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:ListPolicyVersions",
      "iam:CreatePolicyVersion",
      "iam:DeletePolicyVersion"
    ]
    resources = [
      "arn:aws:iam::${var.aws_account_id}:policy/GithubWamMessageECRTerraformStatePolicy"
    ]
  }

  /*statement {
    actions = [
      "apprunner:CreateService",
      "apprunner:DescribeService",
      "apprunner:ListTagsForResource"
    ]
    resources = [
      aws_apprunner_service.wamserver.arn
    ]
  }*/
}

resource "aws_iam_policy" "wam_message_ecr_terraform_state_policy" {
  name        = "GithubWamMessageECRTerraformStatePolicy"
  description = "Allow GitHub Actions to perform terraform apply for wam_message resources related"
  policy      = data.aws_iam_policy_document.terraform_state.json
}

// Attach Policy to the Github Role (reference from bootstrap tfstate)
resource "aws_iam_role_policy_attachment" "wam_message_ecr_terraform_state_attach" {
  role       = data.terraform_remote_state.bootstrap-tfstate.outputs.github_actions_terraform_role_name
  policy_arn = aws_iam_policy.wam_message_ecr_terraform_state_policy.arn
}