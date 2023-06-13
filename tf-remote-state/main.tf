terraform {
  required_providers {
    aws = {
      version = "4.67.0"
    }
  }
}

provider "aws" {
  alias = "eu-west-1"
  region = "eu-west-1"
  profile = "default"
}

resource "aws_s3_bucket" "backend_bucket" {
  bucket = "cardo-test-terraform-backend"
  tags = {
    Environment = "testing"
    Role = "tf_state_storage"
  }
}

resource "aws_dynamodb_table" "tf_backend_lock" {
  name = "terraform_backend_state_lock"
  hash_key = "LockID"
  read_capacity = 5
  write_capacity = 5

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_dynamodb_table" "tf_backend_lock-staging" {
  name = "terraform_backend_staging_state_lock"
  hash_key = "LockID"
  read_capacity = 5
  write_capacity = 5

  attribute {
    name = "LockID"
    type = "S"
  }
}
