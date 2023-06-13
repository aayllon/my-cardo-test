
resource "null_resource" "sync_html" {
  triggers     = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "aws s3 --profile ${var.aws_profile} sync ${var.web_dir_content} s3://${var.web_bucket}"
  }
}

resource "null_resource" "sync_assets" {
  triggers     = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "aws s3 --profile ${var.aws_profile} sync ${var.assets_dir_content} s3://${var.assets_bucket}/assets/"
  }
}