variable "project" {
    description = "name of the rafay project"
}

variable "rafay_cli_config_file" {
  description = "Path to Rafay provider config file"
  type        = string
}

variable "oci_api_key_path" {
    description = "OCI api key path"
    type = string
}
variable "user_ocid" {}
variable "tenancy_ocid" {
  default = "ocid1.tenancy.oc1..aaaaaaaaaa3ghjcqbrbzmssbzhxzhxf24rpmuyxbaxwcj2axwoqkpd56ljkq"
}
variable "fingerprint" {}

variable "agent_name"{
  description = "name of a agent that you have already deployed"
}

variable "oci_image" {
  description = "conainer image of oci cli"
  default = "ghcr.io/oracle/oci-cli:latest"
  
}