variable "region" {
  description = "Default region for resources."
  type        = string
  default     = "eu-west-3"
}

variable "wam_message_gatling_ecr_repo" {
  description = "Repo for wam_message_gatling app"
  type        = string
  default     = "wam_message_gatling"
}
