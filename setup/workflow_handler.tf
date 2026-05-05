resource "rafay_workflow_handler" "start_workflow_handler" {
  metadata {
    name    = "${var.project}-start-oci-instance"
    project = var.project
  }
  spec {
    inputs {
        name = rafay_config_context.oci-authentication.metadata[0].name
    }
    config {
      type            = "container"
      timeout_seconds = 100
      max_retry_count = 3
      container {
        env_vars = {
            oci_instance_id = "#{resource.\"${var.project}-mks-minimal\".output.oci_instance_id.value}#"
            }
        image     = var.oci_image
        commands = ["sh", "-c", "oci compute instance action --action START --instance-id $oci_instance_id --config-file /oracle/.oci/config --query 'data.\"lifecycle-state\"' --raw-output"]  
      }
    }
  }
}

resource "rafay_workflow_handler" "stop_workflow_handler" {
  metadata {
    name    = "${var.project}-stop-oci-instance"
    project = var.project
  }
  spec {
    inputs {
        name = rafay_config_context.oci-authentication.metadata[0].name
    }
    config {
      type            = "container"
      timeout_seconds = 100
      max_retry_count = 3
      container {
        env_vars = {
            oci_instance_id = "#{resource.\"${var.project}-mks-minimal\".output.oci_instance_id.value}#"
            }
        image     = var.oci_image
        commands = ["sh", "-c", "oci compute instance action --action STOP --instance-id $oci_instance_id --config-file /oracle/.oci/config --query 'data.\"lifecycle-state\"' --raw-output"]  
    }
    }
  }
}