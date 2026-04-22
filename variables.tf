variable "tenancy_ocid" {
  description = "OCI Tenancy OCID"
  type        = string
}

variable "user_ocid" {
  description = "OCI User OCID"
  type        = string
}

variable "fingerprint" {
  description = "API key fingerprint"
  type        = string
}

variable "private_key_path" {
  description = "Path to the private key file"
  type        = string
}

variable "region" {
  description = "OCI region"
  type        = string
}

# variable "provider_config_file" {
# description = "Path to Rafay provider config file"
#   type        = string
# }

variable "availability_domain" {
    description = "oci instance availability zone"
}

variable "compartment_id" {
    description = "oci instance compartment id"
}

variable "subnet_id" {
    description = "the subnet on which the instance needs to be created" 
    default = "ocid1.subnet.oc1.phx.aaaaaaaao3w4qqbfsths7gpp5yix2lpw6lzj2wht3q2r2uklsknbentzqchq"
}

variable "image_id" {
    description = "the image id to be used for creating the instance"
    default = "ocid1.image.oc1.phx.aaaaaaaazd3uynnsb57b76dp3c4hkdo2fjjgz5jase5y3cmvttjvpgwnwq4q"
  
}

variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
}

variable "prefix_name" {
    description = "instance display name"
  
}

variable "vcpu" {
    description = "vcpu for your node instance"
    default = 8
}

variable "memory_in_gbs" {
    description = "memory in GB to be assigned for the OCI node instance"
    default = 12
}

variable "project" {
    description = "project on which the cluster needs to be created"
  
}

variable "blueprint" {
    description = "blueprint that need to be applied to the MKS cluster"
    default = "minimal"
}

variable "k8s_ver" {
    description = "K8s version"
    default = "v1.35.0"  
}

variable "platform_ver" {
    description = "platform version"
    default = "v1.2.0"
  
}

variable "cni" {
    description = "cni for MKS cluster"
    default = "Calico"
}

variable "cni_ver" {
    description = "cni version"
    default = "3.31.4"
  
}
variable "pod_subnet" {
  description = "CIDR block for Kubernetes pods"
  type        = string
  default     = "10.244.0.0/16"
}

variable "service_subnet" {
  description = "CIDR block for Kubernetes services"
  type        = string
  default     = "10.96.0.0/12"
}


variable "operating_system" {
    description = "operating system for the node instance"
    default = "Ubuntu24.04"
  
}
variable "private_key" {
  description = "Private SSH key content"
  type        = string
  sensitive   = true
}
