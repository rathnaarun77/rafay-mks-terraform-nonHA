data "oci_core_images" "ubuntu" {
  compartment_id           = var.compartment_id
  operating_system         = var.operating_system
  operating_system_version = var.operating_system_version
  shape = "VM.Standard3.Flex"

  sort_by    = "TIMECREATED"
  sort_order = "DESC"
}

resource "oci_core_instance" "node1" {
  preserve_data_volumes_created_at_launch = false
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  display_name        = "${var.prefix_name}-${local.random_name}-node1"
  shape               = "VM.Standard3.Flex"

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
    source_type             = "image"
    source_id               = data.oci_core_images.ubuntu.images[0].id
    boot_volume_size_in_gbs = 50
  }

  metadata = {
    ssh_authorized_keys = trimspace(var.ssh_public_key)

    user_data = base64encode(<<EOF
#!/bin/bash

iptables -F
iptables -t nat -F
iptables -t mangle -F
iptables -X

apt remove -yq iptables-persistent --purge || true

iptables -F
EOF
    )
  }
  dynamic "launch_volume_attachments" {
    for_each = var.block_vol_size > 0 ? [1] : []

    content {
      type = "PARAVIRTUALIZED"

      display_name = "${var.prefix_name}-${local.random_name}-block"

      launch_create_volume_details {
        compartment_id       = var.compartment_id
        display_name         = "${var.prefix_name}-${local.random_name}-block"
        size_in_gbs          = var.block_vol_size
        volume_creation_type = "ATTRIBUTES"
      }
    }
  }
}