/**
 * The Management instances will be used by instances in private subnets for network security best practices.
 */

resource "oci_core_instance" "ManagementInstanceAD1" {
  count               = "${(var.control_plane_subnet_access == "private") && (var.management_instance_ad1_enabled == "true") ? "1" : "0"}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  compartment_id      = "${(var.multiple_compartments == "true")  ? var.bastion_compartment_ocid : var.compartment_ocid}"
  display_name        = "${var.label_prefix}management-ad1"
  image               = "${lookup(data.oci_core_images.ImageOCID.images[0], "id")}"
  shape               = "${var.management_instance_shape}"

  create_vnic_details {
    subnet_id = "${(var.control_plane_subnet_access == "private") && (var.dedicated_bastion_subnets == "true") ? "${element(concat(oci_core_subnet.ManagementSubnetAD1.*.id,list("")),0)}" : "${oci_core_subnet.PublicSubnetAD1.id}"}"
  }

  metadata {
    ssh_authorized_keys = "${var.management_instance_ssh_public_key_openssh}"
  }

  timeouts {
    create = "10m"
  }
}

resource "oci_core_instance" "ManagementInstanceAD2" {
  count               = "${(var.control_plane_subnet_access == "private") && (var.management_instance_ad2_enabled == "true") ? "1" : "0"}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  compartment_id      = "${(var.multiple_compartments == "true")  ? var.bastion_compartment_ocid : var.compartment_ocid}"
  display_name        = "${var.label_prefix}management-ad2"
  image               = "${lookup(data.oci_core_images.ImageOCID.images[0], "id")}"
  shape               = "${var.management_instance_shape}"

  create_vnic_details {
    subnet_id = "${(var.control_plane_subnet_access == "private") && (var.dedicated_bastion_subnets == "true") ? "${element(concat(oci_core_subnet.ManagementSubnetAD2.*.id,list("")),0)}" : "${oci_core_subnet.PublicSubnetAD2.id}"}"
  }

  metadata {
    ssh_authorized_keys = "${var.management_instance_ssh_public_key_openssh}"
  }

  timeouts {
    create = "10m"
  }
}

resource "oci_core_instance" "ManagementInstanceAD3" {
  count               = "${(var.control_plane_subnet_access == "private") && (var.management_instance_ad3_enabled == "true") ? "1" : "0"}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  compartment_id      = "${(var.multiple_compartments == "true")  ? var.bastion_compartment_ocid : var.compartment_ocid}"
  display_name        = "${var.label_prefix}management-ad3"
  image               = "${lookup(data.oci_core_images.ImageOCID.images[0], "id")}"
  shape               = "${var.management_instance_shape}"

  create_vnic_details {
    subnet_id = "${(var.control_plane_subnet_access == "private") && (var.dedicated_bastion_subnets == "true") ? "${element(concat(oci_core_subnet.ManagementSubnetAD3.*.id,list("")),0)}" : "${element(concat(oci_core_subnet.PublicSubnetAD3.*.id,list("")),0)}"}"
  }

  metadata {
    ssh_authorized_keys = "${var.management_instance_ssh_public_key_openssh}"
  }

  timeouts {
    create = "10m"
  }
}
