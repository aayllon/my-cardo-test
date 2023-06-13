module "ssl-certificate" {
  source   = "../modules/ssl-certificate"
  domain   = "web-staging.mycardo.com"
  zone_id  = "SOMETHING_TO_CHANGE"
}

module "s3-bucket" {
  source      = "../modules/s3-bucket"
  buckets     = {
    "web"     = "cardo-test-web-aayllon-staging",
    "assets"  = "cardo-health-assets-aayllon-staging"
  }
  expiration_days = 90
  tags = {
    "environment" = "staging"
    "role"        = "cardo-test"
  }
}

module "deploy-web" {
  source             = "../modules/deploy-web"
  web_bucket         = module.s3-bucket.s3_bucket_id_web
  assets_bucket      = module.s3-bucket.s3_bucket_id_assets
  web_dir_content    = "../src/html"
  assets_dir_content = "../src/assets"
}

module "static_web" {
  source            = "../modules/static-website"
  web-bucket-id     = module.s3-bucket.s3_bucket_id_web
  assets-bucket-id  = module.s3-bucket.s3_bucket_id_assets
  web-bucket-arn    = module.s3-bucket.s3_bucket_arn_web
  assets-bucket-arn = module.s3-bucket.s3_bucket_arn_assets
  origin            = {
    web = {
      domain_name = module.s3-bucket.s3_bucket_bucket_regional_domain_name_web
      origin_id   = "web_origin"
    }
    assets = {
      domain_name = module.s3-bucket.s3_bucket_bucket_regional_domain_name_assets
      origin_id   = "assets_origin"
    }
  }
  default_cache_behavior = {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "web_origin"
    viewer_protocol_policy = "https-only"
    compress               = true
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
  }
  ordered_cache_behavior = {
    path_pattern           = "/assets/*"
    target_origin_id       = "assets_origin"
    viewer_protocol_policy = "https-only"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
  }
  comment_for_distribution = "CloudFront distribution for Cardo test"
  acm_certificate_arn      = module.ssl-certificate.certificate_arn
  price_class              = "PriceClass_100"
}
