terraform {
  backend "s3" {
    bucket         = "company-terraform-state-dev"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-locks-dev"
  }
}