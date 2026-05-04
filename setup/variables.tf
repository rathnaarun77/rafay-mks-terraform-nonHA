variable "project" {
    description = "name of the rafay project"
}

variable "provider_config_file" {
  description = "Path to Rafay provider config file"
  type        = string
}

variable "oci_api_key" {
    description = "OCI api key"
    type = string
  
}
variable "user_ocid" {}
variable "tenancy_ocid" {}
variable "fingerprint" {}
variable "rctl_api_secret" {}