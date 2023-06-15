variable "domain" {
  type    = string
  default = null
}

variable "zone_id" {
  type    = string
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}
