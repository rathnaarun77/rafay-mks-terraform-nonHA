resource "rafay_config_context" "ssh-keys" {
  metadata {
    name        = "${var.project}-ssh-keys"
    project     = var.project
    description = "this config context is used for rafay authentication"
  }
  spec {
    files {
      name = "/.ssh/mks-key.pub"
      data = nonsensitive(tls_private_key.ssh_key.public_key_pem)
      options  {
        sensitive = false
        override {
          type = "allowed"
        }
      }
    }
    files {
      name = "/.ssh/mks-key"
      data = base64decode(local.private_key_b64)
      options  {
        sensitive = false
        override {
          type = "allowed"
        }
      }
    }
}
}