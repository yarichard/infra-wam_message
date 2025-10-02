resource "aws_ecr_repository" "wam_message_gatling" {
  name = var.wam_message_gatling_ecr_repo

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }
}
