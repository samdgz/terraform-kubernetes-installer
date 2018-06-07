/**
 * The Bastion instances will be used by instances in private subnets for network security best practices.
 */

resource "oci_core_instance" "BastionInstanceAD1" {
  count               = "${(var.control_plane_subnet_access == "private") && (var.bastion_instance_ad1_enabled == "true") ? "1" : "0"}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  compartment_id      = "${(var.multiple_compartments == "true")  ? var.bastion_compartment_ocid : var.compartment_ocid}"
  display_name        = "${(var.region == "us-ashburn-1") ? "ociash1-${var.regulatory_domain}-${var.product_name}-bastion-01" : "ociphx1-${var.regulatory_domain}-${var.product_name}-bastion-01"}"
  image               = "${lookup(data.oci_core_images.BastionImageOCID.images[0], "id")}"
  shape               = "${var.bastion_instance_shape}"
  hostname_label      = "${(var.region == "us-ashburn-1") ? "ociash1-${var.regulatory_domain}-${var.product_name}-bastion-01" : "ociphx1-${var.regulatory_domain}-${var.product_name}-bastion-01"}"

  create_vnic_details {
    subnet_id = "${(var.control_plane_subnet_access == "private") && (var.dedicated_bastion_subnets == "true") ? "${element(concat(oci_core_subnet.BastionSubnetAD1.*.id,list("")),0)}" : "${oci_core_subnet.PublicSubnetAD1.id}"}"
    display_name        = "${(var.region == "us-ashburn-1") ? "ociash1-${var.regulatory_domain}-${var.product_name}-bastion-01" : "ociphx1-${var.regulatory_domain}-${var.product_name}-bastion-01"}"
    hostname_label      = "${(var.region == "us-ashburn-1") ? "ociash1-${var.regulatory_domain}-${var.product_name}-bastion-01" : "ociphx1-${var.regulatory_domain}-${var.product_name}-bastion-01"}"
    assign_public_ip = "true"
    private_ip       = "${var.assign_private_ip == "true" ? cidrhost(lookup(var.network_cidrs,"bastionSubnetAD1"), count.index+2) : ""}"
  }

  metadata {
    ssh_authorized_keys = "${var.bastion_instance_ssh_public_key_openssh}"
    # Automate Bastion instance configuration with cloud init run at launch
    user_data = "${base64encode(file("${path.module}/cloud_init/bastion/bootstrap.template.yaml"))}"
  }

  timeouts {
    create = "10m"
  }
}

resource "oci_core_instance" "BastionInstanceAD2" {
  count               = "${(var.control_plane_subnet_access == "private") && (var.bastion_instance_ad2_enabled == "true") ? "1" : "0"}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  compartment_id      = "${(var.multiple_compartments == "true")  ? var.bastion_compartment_ocid : var.compartment_ocid}"
  display_name        = "${(var.region == "us-ashburn-1") ? "ociash1-${var.regulatory_domain}-${var.product_name}-bastion-02" : "ociphx1-${var.regulatory_domain}-${var.product_name}-bastion-02"}"
  image               = "${lookup(data.oci_core_images.BastionImageOCID.images[0], "id")}"
  shape               = "${var.bastion_instance_shape}"
  hostname_label      = "${(var.region == "us-ashburn-1") ? "ociash1-${var.regulatory_domain}-${var.product_name}-bastion-02" : "ociphx1-${var.regulatory_domain}-${var.product_name}-bastion-02"}"

  create_vnic_details {
    subnet_id = "${(var.control_plane_subnet_access == "private") && (var.dedicated_bastion_subnets == "true") ? "${element(concat(oci_core_subnet.BastionSubnetAD2.*.id,list("")),0)}" : "${oci_core_subnet.PublicSubnetAD2.id}"}"
    display_name        = "${(var.region == "us-ashburn-1") ? "ociash1-${var.regulatory_domain}-${var.product_name}-bastion-02" : "ociphx1-${var.regulatory_domain}-${var.product_name}-bastion-02"}"
    hostname_label      = "${(var.region == "us-ashburn-1") ? "ociash1-${var.regulatory_domain}-${var.product_name}-bastion-02" : "ociphx1-${var.regulatory_domain}-${var.product_name}-bastion-02"}"
    assign_public_ip = "true"
    private_ip       = "${var.assign_private_ip == "true" ? cidrhost(lookup(var.network_cidrs,"bastionSubnetAD2"), count.index+2) : ""}"
  }

  metadata {
    ssh_authorized_keys = "${var.bastion_instance_ssh_public_key_openssh}"
    # Automate Bastion instance configuration with cloud init run at launch
    user_data = "${base64encode(file("${path.module}/cloud_init/bastion/bootstrap.template.yaml"))}"
  }

  timeouts {
    create = "10m"
  }
}

resource "oci_core_instance" "BastionInstanceAD3" {
  count               = "${(var.control_plane_subnet_access == "private") && (var.bastion_instance_ad3_enabled == "true") ? "1" : "0"}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  compartment_id      = "${(var.multiple_compartments == "true")  ? var.bastion_compartment_ocid : var.compartment_ocid}"
  display_name        = "${(var.region == "us-ashburn-1") ? "ociash1-${var.regulatory_domain}-${var.product_name}-bastion-03" : "ociphx1-${var.regulatory_domain}-${var.product_name}-bastion-03"}"
  image               = "${lookup(data.oci_core_images.BastionImageOCID.images[0], "id")}"
  shape               = "${var.bastion_instance_shape}"
  hostname_label      = "${(var.region == "us-ashburn-1") ? "ociash1-${var.regulatory_domain}-${var.product_name}-bastion-03" : "ociphx1-${var.regulatory_domain}-${var.product_name}-bastion-03"}"

  create_vnic_details {
    subnet_id = "${(var.control_plane_subnet_access == "private") && (var.dedicated_bastion_subnets == "true") ? "${element(concat(oci_core_subnet.BastionSubnetAD3.*.id,list("")),0)}" : "${element(concat(oci_core_subnet.PublicSubnetAD3.*.id,list("")),0)}"}"
    display_name        = "${(var.region == "us-ashburn-1") ? "ociash1-${var.regulatory_domain}-${var.product_name}-bastion-03" : "ociphx1-${var.regulatory_domain}-${var.product_name}-bastion-03"}"
    hostname_label      = "${(var.region == "us-ashburn-1") ? "ociash1-${var.regulatory_domain}-${var.product_name}-bastion-03" : "ociphx1-${var.regulatory_domain}-${var.product_name}-bastion-03"}"
    assign_public_ip = "true"
    private_ip       = "${var.assign_private_ip == "true" ? cidrhost(lookup(var.network_cidrs,"bastionSubnetAD3"), count.index+2) : ""}"
  }

  metadata {
    ssh_authorized_keys = "${var.bastion_instance_ssh_public_key_openssh}"
    # Automate Bastion instance configuration with cloud init run at launch
    user_data = "${base64encode(file("${path.module}/cloud_init/bastion/bootstrap.template.yaml"))}"
  }

  timeouts {
    create = "10m"
  }
}
