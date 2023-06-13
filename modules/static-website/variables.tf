variable "create_distribution" {
  type        = bool
  default     = true
}

variable "environment" {
  description = "Name of the environment"
  type        = string
  default     = "development"
}

variable "origin" {
  type        = any
  default     = null
}

variable "web-bucket-id" {
  type    = string
  default = null
}

variable "assets-bucket-id" {
  type    = string
  default = null
}

variable "web-bucket-arn" {
  type    = string
  default = null
}

variable "assets-bucket-arn" {
  type    = string
  default = null
}

variable "bucket_names" {
  description = "Names for the buckets to store code and assets"
  type        = map(string)
  default     = {
    "frontend"    = "cardohealth-test-frontend-aayllon",
    "assets"      = "cardohealth-test-assets-aayllon"
  }
}

variable "tags" {
  description = "Tags to set on resources"
  type        = map(string)
  default     = {
    "environment"  = "development"
    "project"      = "cadohealth-test"
  }
}

variable "default_cache_behavior" {
  type      = any
  default   = null
}

variable "ordered_cache_behavior" {
  type        = any
  default     = null
}

variable "enabled" {
  type    = bool
  default = true
}

variable "ipv6_enabled" {
  type    = bool
  default = true
}

variable "comment_for_distribution" {
  type    = string
  default = null
}

variable "default_root_object" {
  type    = string
  default = "index.html"
}

variable "price_class" {
  type    = string
  default = null
}

variable "acm_certificate_arn" {
  type    = string
  default = null
}
