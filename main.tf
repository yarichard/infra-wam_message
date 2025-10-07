provider "aws" {
  region = var.region
}

/*resource "aws_apprunner_service" "wamserver" {
  service_name = "wamserver"

  source_configuration {
    authentication_configuration {
      access_role_arn = aws_iam_role.apprunner_ecr_role.arn
    }
    image_repository {
      image_identifier      = "${var.aws_account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.wamserver_ecr_repo}:latest"
      image_repository_type = "ECR"
      image_configuration {
        port = "3000"
      }
    }
  }

  instance_configuration {
    cpu    = "256"
    memory = "512"
  }

  tags = {
    Name = "wamserver"
  }
}
*/