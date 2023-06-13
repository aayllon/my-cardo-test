
provider "aws" {
  alias   = "certificate"
  region  = "us-east-1"
  profile = "acm"
}


resource "aws_acm_certificate" "default" {
  provider                  = aws.certificate
  domain_name               = var.domain
  subject_alternative_names = ["*.${var.domain}"]
  validation_method         = "DNS"
  lifecycle {
    create_before_destroy   = true
  }
}
resource "aws_route53_record" "validation" {
  zone_id = var.zone_id
  name    = tolist(aws_acm_certificate.default.domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.default.domain_validation_options)[0].resource_record_type
  records = [tolist(aws_acm_certificate.default.domain_validation_options)[0].resource_record_value]
  ttl = "300"
}

resource "aws_acm_certificate_validation" "default" {
  provider                = aws.certificate
  certificate_arn         = aws_acm_certificate.default.arn
  validation_record_fqdns = [aws_route53_record.validation.fqdn]
}
