terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.67.0"
    }
  }
  required_version = "1.4.6"
  backend "s3" {
    bucket         = "cardo-test-terraform-backend"
    key            = "cardohealth-test.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform_backend_state_lock"
  }
}

provider "aws" {
  region  = "eu-west-1"
  profile = "default"
}
