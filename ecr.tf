resource "aws_ecr_repository" "wamserver" {
  name = var.wamserver_ecr_repo

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  force_delete = true
}
