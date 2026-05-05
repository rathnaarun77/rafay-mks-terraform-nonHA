resource "rafay_config_context" "ssh-keys" {
  metadata {
    name        = "${var.project}-ssh-keys"
    project     = var.project
    description = "this config context is used for rafay authentication"
  }
  spec {
    variables {
      name       = "ssh_public_key"
      value_type = "text"
      value      = nonsensitive(tls_private_key.ssh_key.public_key_openssh)
      options {
        override {
          type  = "allowed"
        }
        sensitive   = true
      }
    }
    variables {
      name       = "private_key"
      value_type = "text"
      value      = base64decode(local.private_key_b64)
      options {
        override {
          type  = "allowed"
        }
        sensitive   = true
      }
    }
}
}