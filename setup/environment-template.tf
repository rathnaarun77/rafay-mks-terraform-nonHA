resource "rafay_environment_template" "mks-et-minimal" {
  metadata {
    name    = "${var.project}-mks-et-minimal"
    project = var.project
    display_name = "mks-minimal"
  }
  spec {
    version = "v1"
    actions {
      name = "stop-oci-instance"
      type = "workflows"
      workflows {
        tasks {
          agents {
            name = var.agent_name
          }
          name = "powerOFF"
          type = "workflowHandler"
          workflow_handler {
            name = rafay_workflow_handler.stop_workflow_handler.metadata[0].name
          }
        }
      }
    }
    actions {
      name = "start-oci-instance"
      type = "workflows"
      workflows {
        tasks {
          agents {
            name = var.agent_name
          }
          name = "powerON"
          type = "workflowHandler"
          workflow_handler {
            name = rafay_workflow_handler.start_workflow_handler.metadata[0].name
          }
        }
      }
    }
    resources {
      type = "dynamic"
      kind = "resourcetemplate"
      name = rafay_resource_template.mks_minimal.metadata[0].name
      resource_options {
        version   = "v1"
        dedicated = false
      }
    }
    agents {
      name = var.agent_name
    }
    contexts {
      name = rafay_config_context.oci-authentication.metadata[0].name
    }
    contexts {
      name = rafay_config_context.rafay-authentication.metadata[0].name
    }
    contexts {
      name = rafay_config_context.ssh-keys.metadata[0].name
    }
  }
}