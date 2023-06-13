output "s3_bucket_id_web" {
  value = try(aws_s3_bucket.web[0].id, "")
}

output "s3_bucket_arn_web" {
  value = try(aws_s3_bucket.web[0].arn, "")
}

output "s3_bucket_bucket_domain_name_web" {
  value = try(aws_s3_bucket.web[0].bucket_domain_name, "")
}

output "s3_bucket_bucket_regional_domain_name_web" {
  value = try(aws_s3_bucket.web[0].bucket_regional_domain_name, "")
}

output "s3_bucket_id_assets" {
  value = try(aws_s3_bucket.assets[0].id, "")
}

output "s3_bucket_arn_assets" {
  value = try(aws_s3_bucket.assets[0].arn, "")
}

output "s3_bucket_bucket_domain_name_assets" {
  value = try(aws_s3_bucket.assets[0].bucket_domain_name, "")
}

output "s3_bucket_bucket_regional_domain_name_assets" {
  value = try(aws_s3_bucket.assets[0].bucket_regional_domain_name, "")
}
