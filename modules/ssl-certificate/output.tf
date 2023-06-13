output "certificate_arn" {
  value = try(aws_acm_certificate.default.arn, "")
}
