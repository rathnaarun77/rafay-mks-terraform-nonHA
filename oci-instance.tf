data "oci_core_images" "ubuntu" {
  compartment_id           = var.compartment_ocid
  operating_system         = "Canonical Ubuntu"
  operating_system_version = "24.04"

  sort_by    = "TIMECREATED"
  sort_order = "DESC"
}
resource "oci_core_instance" "node1" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  display_name        = "${var.prefix_name}-${local.random_name}-node1"

  shape = "VM.Standard3.Flex"
  shape_config {
    ocpus         = ceil(var.vcpu / 2)
    memory_in_gbs = var.memory_in_gbs
  }

  create_vnic_details {
    subnet_id        = var.subnet_id
    assign_public_ip = true
    hostname_label   = "${var.prefix_name}-${local.random_name}-node1"
  }

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.ubuntu.images[0].id
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key_path)

    user_data = base64encode(<<EOF
#!/bin/bash

# Flush iptables
iptables -F
iptables -t nat -F
iptables -t mangle -F
iptables -X

# Remove iptables-persistent (Debian/Ubuntu)
apt remove -yq iptables-persistent --purge || true

# Flush again just in case
iptables -F
EOF
    )
  }
}
