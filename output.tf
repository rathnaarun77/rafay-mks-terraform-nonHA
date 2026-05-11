output "oci_node_names" {
  description = "Display names of all OCI nodes"

  value = [
    for instance in oci_core_instance.nodes :
    instance.display_name
  ]
}

output "ssh_oci_nodes" {
  description = "SSH commands for all OCI nodes"

  value = [
    for instance in oci_core_instance.nodes :
    "ssh ubuntu@${instance.public_ip}"
  ]
}

output "mks_cluster_name" {
  description = "Name of the MKS cluster"

  value = rafay_mks_cluster.mks-cluster.metadata.name
}

output "kubeconfig_cluster" {
  description = "Kubeconfig for the cluster"

  value = data.rafay_download_kubeconfig.kubeconfig_cluster.kubeconfig

  sensitive = true
}

output "oci_instance_ids" {
  description = "OCI instance IDs"

  value = [
    for instance in oci_core_instance.nodes :
    instance.id
  ]
}

output "oci_private_ips" {
  description = "Private IPs of OCI nodes"

  value = [
    for instance in oci_core_instance.nodes :
    instance.private_ip
  ]
}

output "oci_public_ips" {
  description = "Public IPs of OCI nodes"

  value = [
    for instance in oci_core_instance.nodes :
    instance.public_ip
  ]
}