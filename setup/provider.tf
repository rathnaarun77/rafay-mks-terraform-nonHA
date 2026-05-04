terraform {
  required_providers {
    rafay = {
      source  = "RafaySystems/rafay"
      version = "1.1.62"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "rafay" {
}
