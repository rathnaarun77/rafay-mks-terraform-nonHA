resource "random_string" "random-name" {
  length  = 4
  upper   = false
  lower   = true
  numeric = true
  special = false
}

locals {
  random_name = random_string.random-name.result
}

