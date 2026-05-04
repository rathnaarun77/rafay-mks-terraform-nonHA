resource "rafay_config_context" "rafay-authentication" {
  metadata {
    name        = rafay-authentication
    project     = var.project
    description = "this config is used for rafay authentication"
  }
  spec {
    envs {
      key       = "RCTL_API_KEY"
      value     = "modified-value"
      options = {
        sensitive = true
        override = {
          type = "allowed"
        }
      }
    }
    envs {
      key       = "RCTL_REST_ENDPOINT"
      value     = "console.rafay.dev"
    }
    envs {
      key       = "RCTL_PROJECT"
      value     = var.project
    }
}
}