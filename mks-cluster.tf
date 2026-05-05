resource "local_file" "ssh_key" {
  content  = var.private_key
  filename = "${path.module}/temp_key.pem"
}

resource "rafay_mks_cluster" "mks-cluster" {
  api_version = "infra.k8smgmt.io/v3"
  kind        = "Cluster"
  metadata = {
    name    = "${var.prefix_name}-${local.random_name}"
    project = var.project
  }
  spec = {
    blueprint = {
      name = var.blueprint
    }
    config = {
      auto_approve_nodes      = true
      kubernetes_version      = var.k8s_ver
      installer_ttl           = 365
      platform_version        = var.platform_ver
      network = {
        cni = {
          name    = var.cni
          version = var.cni_ver
        }
        pod_subnet     = var.pod_subnet
        service_subnet = var.service_subnet
      }
      cluster_ssh = {
        username         = "ubuntu"
        port             = "22"
        private_key_path = local_file.ssh_key.filename
      }
      nodes = {
        (oci_core_instance.node1.display_name) = {
          arch             = "amd64"
          hostname         = oci_core_instance.node1.display_name
          operating_system = var.mks_operating_system
          private_ip       = oci_core_instance.node1.private_ip

          roles = concat(
            ["ControlPlane", "Worker"],
            var.block_vol_size > 0 ? ["Storage"] : []
          )

          ssh = {
            ip_address = oci_core_instance.node1.public_ip
          }
        }
      }
        }
      }
    }

# get kubeconfig for a cluster
data "rafay_download_kubeconfig" "kubeconfig_cluster" {
  cluster = rafay_mks_cluster.mks-cluster.metadata.name
}

