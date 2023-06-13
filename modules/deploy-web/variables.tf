variable "aws_profile" {
  type    = string
  default = "default"
}

variable "web_bucket" {
  type    = string
  default = null
}

variable "assets_bucket" {
  type    = string
  default = null
}

variable "web_dir_content" {
  type    = string
  default = null
}

variable "assets_dir_content" {
  type    = string
  default = null
}
