locals {
  create_frontend_bucket = var.create_frontend_bucket
  create_assets_bucket = var.create_assets_bucket
}

resource "aws_s3_bucket" "web" {
  count  = local.create_frontend_bucket ? 1 : 0

  bucket = var.buckets.web
  tags   = var.tags
}

resource "aws_s3_bucket_lifecycle_configuration" "retention_config_web" {
  for_each = var.buckets
  bucket   = each.value
  rule {
    id     = "default"
    expiration {
      days = var.expiration_days
    }
    status = var.enabled_expiration
  }
}

resource "aws_s3_bucket" "assets" {
  count   = local.create_assets_bucket ? 1 : 0

  bucket = var.buckets.assets
  tags   = var.tags
}
