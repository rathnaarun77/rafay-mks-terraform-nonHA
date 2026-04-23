output "oci_node_name"{
    value = oci_core_instance.node1.display_name
}

output "oci_node_public_IP" {
    value = oci_core_instance.node1.public_ip
}

output "oci_node_private_IP" {
    value = oci_core_instance.node1.private_ip
}

output "mks_cluster_name" {
    value = rafay_mks_cluster.mks-cluster.metadata.name
  
}