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
      auto_approve_nodes = true
      kubernetes_version = var.k8s_ver
      installer_ttl      = 365
      platform_version   = var.platform_ver

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
        for idx, instance in oci_core_instance.nodes :
        instance.display_name => {
          arch             = "amd64"
          hostname         = instance.display_name
          operating_system = var.mks_operating_system
          private_ip       = instance.private_ip

          roles = concat(
            (
              var.dedicated_master ?
              (
                idx < var.cp_count ?
                ["ControlPlane"] :
                ["Worker"]
              ) :
              (
                idx < var.cp_count ?
                ["ControlPlane", "Worker"] :
                ["Worker"]
              )
            ),
            var.block_vol_size > 0 ? ["Storage"] : []
          )

          ssh = {
            ip_address = instance.public_ip
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