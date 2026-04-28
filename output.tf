output "oci_node_name"{
    value = oci_core_instance.node1.display_name
}

output "ssh_oci_node" {
  value = "ssh ubuntu@${oci_core_instance.node1.public_ip}"
}

output "mks_cluster_name" {
    value = rafay_mks_cluster.mks-cluster.metadata.name
  
}

output "kubeconfig_cluster" {
  description = "kubeconfig_cluster"
  value       = data.rafay_download_kubeconfig.kubeconfig_cluster.kubeconfig
}

output "start_oci_instance" {
  description = "command to start the oci instance"
  value       = "oci compute instance action --instance-id ${oci_core_instance.node1.id} --action START"
}