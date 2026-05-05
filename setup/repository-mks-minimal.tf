# Username/Password example
resource "rafay_repositories" "mks-minimal-repo" {
  metadata {
    name    = "mks-terraform-minimal"
    project = var.project
  }
  spec {
    type = "Git"
    endpoint = "https://github.com/rathnaarun77/rafay-mks-terraform-nonHA.git"
  }
}