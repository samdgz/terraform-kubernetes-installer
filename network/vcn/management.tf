/**
 * The Management instances will be used by instances in private subnets for network security best practices.
 */

resource "oci_core_instance" "ManagementInstanceAD1" {
  count               = "${(var.control_plane_subnet_access == "private") && (var.management_instance_ad1_enabled == "true") ? "1" : "0"}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  compartment_id      = "${(var.multiple_compartments == "true")  ? var.bastion_compartment_ocid : var.compartment_ocid}"
  display_name        = "${var.label_prefix}management-ad1"
  image               = "${lookup(data.oci_core_images.ManagementImageOCID.images[0], "id")}"
  shape               = "${var.management_instance_shape}"
  preserve_boot_volume = "${var.preserve_boot_volume}"

  create_vnic_details {
    subnet_id = "${(var.control_plane_subnet_access == "private") && (var.dedicated_bastion_subnets == "true") ? "${element(concat(oci_core_subnet.ManagementSubnetAD1.*.id,list("")),0)}" : "${oci_core_subnet.PublicSubnetAD1.id}"}"
    display_name        = "${var.label_prefix}management-ad1"
    assign_public_ip = "${(var.control_plane_subnet_access == "private") ? "false" : "true"}"
    private_ip       = "${var.assign_private_ip == "true" ? cidrhost(lookup(var.network_cidrs,"managementSubnetAD1"), count.index+2) : ""}"
  }

  extended_metadata {
    ssh_authorized_keys = "${var.management_instance_ssh_public_key_openssh}"
    #Automate management instance configuration with cloud init run at launch time
    user_data = "${data.template_cloudinit_config.management.rendered}"
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
  image               = "${lookup(data.oci_core_images.ManagementImageOCID.images[0], "id")}"
  shape               = "${var.management_instance_shape}"
  preserve_boot_volume = "${var.preserve_boot_volume}"

  create_vnic_details {
    subnet_id = "${(var.control_plane_subnet_access == "private") && (var.dedicated_bastion_subnets == "true") ? "${element(concat(oci_core_subnet.ManagementSubnetAD2.*.id,list("")),0)}" : "${oci_core_subnet.PublicSubnetAD2.id}"}"
    display_name        = "${var.label_prefix}management-ad2"
    assign_public_ip = "${(var.control_plane_subnet_access == "private") ? "false" : "true"}"
    private_ip       = "${var.assign_private_ip == "true" ? cidrhost(lookup(var.network_cidrs,"managementSubnetAD2"), count.index+2) : ""}"
  }

  extended_metadata {
    ssh_authorized_keys = "${var.management_instance_ssh_public_key_openssh}"
    #Automate management instance configuration with cloud init run at launch time
    user_data = "${data.template_cloudinit_config.management.rendered}"
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
  image               = "${lookup(data.oci_core_images.ManagementImageOCID.images[0], "id")}"
  shape               = "${var.management_instance_shape}"
  preserve_boot_volume = "${var.preserve_boot_volume}"

  create_vnic_details {
    subnet_id = "${(var.control_plane_subnet_access == "private") && (var.dedicated_bastion_subnets == "true") ? "${element(concat(oci_core_subnet.ManagementSubnetAD3.*.id,list("")),0)}" : "${element(concat(oci_core_subnet.PublicSubnetAD3.*.id,list("")),0)}"}"
    display_name        = "${var.label_prefix}management-ad3"
    assign_public_ip = "${(var.control_plane_subnet_access == "private") ? "false" : "true"}"
    private_ip       = "${var.assign_private_ip == "true" ? cidrhost(lookup(var.network_cidrs,"managementSubnetAD3"), count.index+2) : ""}"
  }

  extended_metadata {
    ssh_authorized_keys = "${var.management_instance_ssh_public_key_openssh}"
    #Automate management instance configuration with cloud init run at launch time
    user_data = "${data.template_cloudinit_config.management.rendered}"
  }

  timeouts {
    create = "10m"
  }
}
