terraform {
  backend "s3" {
    bucket         = "company-terraform-state-prod"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-locks-prod"
  }
}