resource "rafay_resource_template" "mks_minimal" {
  metadata {
    name    = "${var.project}-mks-minimal"
    project = var.project
  }

  spec {
    version  = "v1"
    provider = "opentofu"
    provider_options {
      open_tofu {
        refresh {
          value = true
        }
        version      = "1.6.2"
        backend_type = "system"
      }
    }

    repository_options {
      name           = "mks-terraform-minimal"
      branch         = "test"
      directory_path = "./"
    }

    variables {
      name       = "availability_domain"
      value_type = "text"
      value      = "PaOl:PHX-AD-2"

      options {
        override {
          type = "restricted"
          restricted_values = [
            "PaOl:PHX-AD-1",
            "PaOl:PHX-AD-2",
            "PaOl:PHX-AD-3"
          ]
        }
      }
    }

    variables {
      name       = "subnet_id"
      value_type = "text"
      value      = "ocid1.subnet.oc1.phx.aaaaaaaao3w4qqbfsths7gpp5yix2lpw6lzj2wht3q2r2uklsknbentzqchq"
      options {
        override {
          type = "allowed"
        }
      }
    }

    variables {
      name       = "prefix_name"
      value_type = "text"

      options {
        description = "prefix name for your mks cluster"
        required    = true

        override {
          type = "allowed"
        }
      }
    }

    variables {
      name       = "vcpu"
      value_type = "text"
      value      = "8"

      options {
        description = "vCPU of the OCI instance"

        override {
          type = "allowed"
        }
      }
    }

    variables {
      name       = "memory_in_gbs"
      value_type = "text"
      value      = "12"

      options {
        description = "memory of the OCI instance"

        override {
          type = "allowed"
        }
      }
    }

    variables {
      name       = "blueprint"
      value_type = "text"
      value      = "minimal"

      options {
        override {
          type = "restricted"
          restricted_values = [
            "minimal",
            "default",
            "default-upstream"
          ]
        }
      }
    }

    variables {
      name       = "k8s_ver"
      value_type = "text"
      value      = "v1.34.1"

      options {
        override {
          type = "allowed"
        }
      }
    }

    variables {
      name       = "platform_ver"
      value_type = "text"
      value      = "v1.2.0"

      options {
        override {
          type = "allowed"
        }
      }
    }

    variables {
      name       = "cni"
      value_type = "text"
      value      = "Calico"

      options {
        override {
          type = "allowed"
        }
      }
    }

    variables {
      name       = "cni_ver"
      value_type = "text"
      value      = "3.31.4"

      options {
        override {
          type = "allowed"
        }
      }
    }

    variables {
      name       = "pod_subnet"
      value_type = "text"
      value      = "10.244.0.0/16"

      options {
        override {
          type = "allowed"
        }
      }
    }

    variables {
      name       = "service_subnet"
      value_type = "text"
      value      = "10.96.0.0/12"

      options {
        override {
          type = "allowed"
        }
      }
    }

    variables {
      name       = "block_vol_size"
      value_type = "text"
      value      = "0"

      options {
        description = "Block volume size in GB, leave it \"0\" to skip attaching"
        required    = true

        override {
          type = "allowed"
        }
      }
    }

  }
}