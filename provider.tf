terraform {
  required_providers {
    rafay = {
      source  = "RafaySystems/rafay"
      version = "1.1.61"
    }
    oci = {
      source  = "oracle/oci"
      version = "8.10.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "rafay" {
  provider_config_file = var.provider_config_file
}

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}