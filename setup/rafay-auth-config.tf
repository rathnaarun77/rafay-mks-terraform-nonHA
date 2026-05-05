locals {
  rafay_creds = jsondecode(file(var.rafay_cli_config_file))
}

resource "rafay_config_context" "rafay-authentication" {
  metadata {
    name        = "${var.project}-rafay-authentication"
    project     = var.project
    description = "this config context is used for rafay authentication"
  }
  spec {
    envs {
      key   = "RCTL_API_KEY"
      value = local.rafay_creds.api_key

      options {
        sensitive = true
        override {
          type = "allowed"
        }
      }
    }
    envs {
      key   = "RCTL_REST_ENDPOINT"
      value = "console.rafay.dev"
    }
    envs {
      key   = "RCTL_PROJECT"
      value = var.project
    }
  }
}