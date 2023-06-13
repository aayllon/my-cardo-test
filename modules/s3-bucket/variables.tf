variable "create_frontend_bucket" {
  type        = bool
  default     = true
}

variable "create_assets_bucket" {
  type        = bool
  default     = true
}

variable "buckets" {
  type = map(string)
  default    = {
    "web"    = "cardo-test-web-aayllon",
    "assets" = "cardo-test-assets-aayllon"
  }
}

variable "expiration_days" {
  type    = number
  default = null
}

variable "enabled_expiration" {
  type    = string
  default = "Enabled"
}

variable "tags" {
  type    = map(string)
  default = {}
}
