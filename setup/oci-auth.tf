resource "rafay_config_context" "config-context-example" {
  metadata {
    name        = "oci_authentication"
    project     = var.project
    description = "this is a config context created for OCI authentication"
  }
  spec {
    envs {
      key       = "name-modified"
      value     = "modified-value"
      options = {
        description = "contains the input variables with default values"
        sensitive = false
        override = {
          type = "allowed"
        }
      }
    }
    envs {
      key       = "name-new"
      value     = "new-value"
    }
    files {
      name      = "file://variables.tf"
      mount_path = "/mnt/eaas/files"
      options = {
        description = "contains the input variables with default values"
        sensitive = true
        override = {
          type = "allowed"
        }
      }
    }
    variables {
      name       = "new-variable"
      value_type = "text"
      value      = "new-value"
      options {
        override {
          type              = "restricted"
          restricted_values = ["new-value", "modified-value"]
        }
        description = "this is a dummy variable"
        sensitive   = false
        required    = true
      }
    }
  }
}