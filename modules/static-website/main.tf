resource "aws_s3_bucket_policy" "allow_access_to_web_code" {
  bucket = var.web-bucket-id
  policy = data.aws_iam_policy_document.allow_access_web_from_cf_distribution.json
}

resource "aws_s3_bucket_policy" "allow_access_to_assets" {
  bucket = var.assets-bucket-id
  policy = data.aws_iam_policy_document.allow_access_assets_from_cf_distribution.json
}

data "aws_iam_policy_document" "allow_access_web_from_cf_distribution" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    actions = [
      "s3:GetObject"
    ]
    resources = [
      var.web-bucket-arn,
      "${var.web-bucket-arn}/*"
    ]
    condition {
      test     = "StringEquals"
      values   = [aws_cloudfront_distribution.cardohealth_web[0].arn]
      variable = "AWS:SourceArn"
    }
  }
}

data "aws_iam_policy_document" "allow_access_assets_from_cf_distribution" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    actions = [
      "s3:GetObject"
    ]
    resources = [
      var.assets-bucket-arn,
      "${var.assets-bucket-arn}/*"
    ]
    condition {
      test     = "StringEquals"
      values   = [aws_cloudfront_distribution.cardohealth_web[0].arn]
      variable = "AWS:SourceArn"
    }
  }
}

resource "aws_cloudfront_distribution" "cardohealth_web" {
  count = var.create_distribution ? 1 : 0

  dynamic "origin" {
    for_each = var.origin
    content {
      domain_name              = origin.value.domain_name
      origin_id                = origin.value.origin_id
      origin_access_control_id = aws_cloudfront_origin_access_control.cardohealth-test-aayllon.id
    }
  }

  enabled = var.enabled
  is_ipv6_enabled     = var.ipv6_enabled
  comment             = var.comment_for_distribution
  default_root_object = var.default_root_object

  dynamic "default_cache_behavior" {
    for_each = [var.default_cache_behavior]
    iterator = i

    content {
      allowed_methods        = i.value["allowed_methods"]
      cached_methods         = i.value["cached_methods"]
      target_origin_id       = i.value["target_origin_id"]
      viewer_protocol_policy = i.value["viewer_protocol_policy"]
      compress               = i.value["compress"]
      cache_policy_id        = i.value["cache_policy_id"]
    }
  }

  dynamic "ordered_cache_behavior" {
    for_each = [var.ordered_cache_behavior]
    iterator = i

    content {
      path_pattern           = i.value["path_pattern"]
      target_origin_id       = i.value["target_origin_id"]
      viewer_protocol_policy = i.value["viewer_protocol_policy"]
      allowed_methods        = i.value["allowed_methods"]
      cached_methods         = i.value["cached_methods"]
      compress               = i.value["compress"]
      cache_policy_id        = i.value["cache_policy_id"]
    }
  }

  price_class = var.price_class
  tags = {
    Environment = "testing"
  }
  viewer_certificate {
    cloudfront_default_certificate = true
    #acm_certificate_arn = var.acm_certificate_arn
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

resource "aws_cloudfront_origin_access_control" "cardohealth-test-aayllon" {
  name = "cardohealth-test"
  description                       = "Policy to allow access to S3 buckets"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
