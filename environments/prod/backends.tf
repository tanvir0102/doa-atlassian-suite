terraform {
  backend "s3" {
    bucket         = "iac-poc-app-terraform-tfstate"
    key            = "iac-poc-app/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "iac-poc-app"
  }
}
