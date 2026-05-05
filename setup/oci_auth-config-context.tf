resource "local_file" "oci_config" {
  filename = "${path.module}/config"

  content = <<EOT
[DEFAULT]
user=${var.user_ocid}
fingerprint=${var.fingerprint}
key_file=/.oci/oci_api_key.pem
tenancy=${var.tenancy_ocid}
region=us-phoenix-1
EOT
}

resource "rafay_config_context" "oci-authentication" {
  metadata {
    name        = "${var.project}-oci-authentication"
    project     = var.project
    description = "this config context is used for oci authentication"
  }

  spec {
    files {
      name = "/.oci/oci_api_key.pem"
      data = file(var.oci_api_key_path)
      options  {
        sensitive = true
        override {
          type = "allowed"
        }
      }
    }
    files {
      name = "/oracle/.oci/config"
      data = local_file.oci_config.content
      options  {
        sensitive = false
        override {
          type = "allowed"
        }
      }
    }
    variables {
      name       = "tenancy_ocid"
      value_type = "text"
      value      = "${var.tenancy_ocid}"
      options {
        override {
          type  = "allowed"
        }
        sensitive   = false
      }
    }
    variables {
      name       = "user_ocid"
      value_type = "text"
      value      = nonsensitive(var.user_ocid)
      options {
        override {
          type  = "allowed"
        }
        sensitive   = false
      }
    }
    variables {
      name       = "fingerprint"
      value_type = "text"
      value      = nonsensitive(var.fingerprint)
      options {
        override {
          type  = "allowed"
        }
        sensitive   = true
      }
    }
    variables {
      name       = "private_key_path"
      value_type = "text"
      value      = "/.oci/oci_api_key.pem"
      options {
        override {
          type  = "allowed"
        }
        sensitive   = false
      }
    }
    variables {
      name       = "region"
      value_type = "text"
      value      = "us-phoenix-1"
      options {
        override {
          type  = "allowed"
        }
        sensitive   = false
      }
    }
    variables {
      name       = "compartment_id"
      value_type = "text"
      value      = nonsensitive(var.tenancy_ocid)
      options {
        override {
          type  = "allowed"
        }
        sensitive   = false
      }
    }
    variables {
      name       = "project"
      value_type = "text"
      value      = var.project
      options {
        override {
          type  = "allowed"
        }
        sensitive   = false
      }
    }
}
}