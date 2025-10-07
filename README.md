# Infra IaC for wam_message project
A manual terraform apply needs to be done to initialize GithubAction IAM permissions

## Prerequisites

- Install pre-commit command (run pip install or brew install)
- run pre-commit install 
- A first terraform init & install should be launched before letting CI apply code to initalize all iam permissions
- this project depends on terraform bootstrap project that initializes AWS S3 bucket to store tfstates