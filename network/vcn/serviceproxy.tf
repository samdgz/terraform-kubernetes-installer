/**
 * The ServiceProxy instances will be used by instances in private subnets for network security best practices.
 */

resource "oci_core_instance" "ServiceProxyInstanceAD1" {
  count               = "${(var.control_plane_subnet_access == "private") && (var.serviceproxy_instance_ad1_enabled == "true") ? "1" : "0"}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  compartment_id      = "${(var.multiple_compartments == "true")  ? var.bastion_compartment_ocid : var.compartment_ocid}"
  display_name        = "${(var.region == "us-ashburn-1") ? "ociash1-${var.regulatory_domain}-${var.product_name}-lbp-01" : "ociphx1-${var.regulatory_domain}-${var.product_name}-lbp-01"}"
  image               = "${lookup(data.oci_core_images.ServiceProxyImageOCID.images[0], "id")}"
  shape               = "${var.serviceproxy_instance_shape}"
  hostname_label      = "${(var.region == "us-ashburn-1") ? "ociash1-${var.regulatory_domain}-${var.product_name}-lbp-01" : "ociphx1-${var.regulatory_domain}-${var.product_name}-lbp-01"}"
  preserve_boot_volume = "${var.preserve_boot_volume}"

  create_vnic_details {
    subnet_id = "${(var.control_plane_subnet_access == "private") && (var.dedicated_bastion_subnets == "true") ? "${element(concat(oci_core_subnet.ServiceProxySubnetAD1.*.id,list("")),0)}" : "${oci_core_subnet.PublicSubnetAD1.id}"}"
    display_name        = "${(var.region == "us-ashburn-1") ? "ociash1-${var.regulatory_domain}-${var.product_name}-lbp-01" : "ociphx1-${var.regulatory_domain}-${var.product_name}-lbp-01"}"
    hostname_label      = "${(var.region == "us-ashburn-1") ? "ociash1-${var.regulatory_domain}-${var.product_name}-lbp-01" : "ociphx1-${var.regulatory_domain}-${var.product_name}-lbp-01"}"
    assign_public_ip = "true"
    private_ip       = "${var.assign_private_ip == "true" ? cidrhost(lookup(var.network_cidrs,"serviceProxySubnetAD1"), count.index+2) : ""}"
  }

  metadata {
    ssh_authorized_keys = "${var.serviceproxy_instance_ssh_public_key_openssh}"
    # Automate ServiceProxy instance configuration with cloud init run at launch
    user_data = "${base64encode(file("${path.module}/cloud_init/serviceproxy/bootstrap.template.yaml"))}"
  }

  timeouts {
    create = "10m"
  }
}

resource "oci_core_instance" "ServiceProxyInstanceAD2" {
  count               = "${(var.control_plane_subnet_access == "private") && (var.serviceproxy_instance_ad2_enabled == "true") ? "1" : "0"}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  compartment_id      = "${(var.multiple_compartments == "true")  ? var.bastion_compartment_ocid : var.compartment_ocid}"
  display_name        = "${(var.region == "us-ashburn-1") ? "ociash1-${var.regulatory_domain}-${var.product_name}-lbp-02" : "ociphx1-${var.regulatory_domain}-${var.product_name}-lbp-02"}"
  image               = "${lookup(data.oci_core_images.ServiceProxyImageOCID.images[0], "id")}"
  shape               = "${var.serviceproxy_instance_shape}"
  hostname_label      = "${(var.region == "us-ashburn-1") ? "ociash1-${var.regulatory_domain}-${var.product_name}-lbp-02" : "ociphx1-${var.regulatory_domain}-${var.product_name}-lbp-02"}"
  preserve_boot_volume = "${var.preserve_boot_volume}"

  create_vnic_details {
    subnet_id = "${(var.control_plane_subnet_access == "private") && (var.dedicated_bastion_subnets == "true") ? "${element(concat(oci_core_subnet.ServiceProxySubnetAD2.*.id,list("")),0)}" : "${oci_core_subnet.PublicSubnetAD2.id}"}"
    display_name        = "${(var.region == "us-ashburn-1") ? "ociash1-${var.regulatory_domain}-${var.product_name}-lbp-02" : "ociphx1-${var.regulatory_domain}-${var.product_name}-lbp-02"}"
    hostname_label      = "${(var.region == "us-ashburn-1") ? "ociash1-${var.regulatory_domain}-${var.product_name}-lbp-02" : "ociphx1-${var.regulatory_domain}-${var.product_name}-lbp-02"}"
    assign_public_ip = "true"
    private_ip       = "${var.assign_private_ip == "true" ? cidrhost(lookup(var.network_cidrs,"serviceProxySubnetAD2"), count.index+2) : ""}"
  }

  metadata {
    ssh_authorized_keys = "${var.serviceproxy_instance_ssh_public_key_openssh}"
    # Automate ServiceProxy instance configuration with cloud init run at launch
    user_data = "${base64encode(file("${path.module}/cloud_init/serviceproxy/bootstrap.template.yaml"))}"
  }

  timeouts {
    create = "10m"
  }
}

resource "oci_core_instance" "ServiceProxyInstanceAD3" {
  count               = "${(var.control_plane_subnet_access == "private") && (var.serviceproxy_instance_ad3_enabled == "true") ? "1" : "0"}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  compartment_id      = "${(var.multiple_compartments == "true")  ? var.bastion_compartment_ocid : var.compartment_ocid}"
  display_name        = "${(var.region == "us-ashburn-1") ? "ociash1-${var.regulatory_domain}-${var.product_name}-lbp-03" : "ociphx1-${var.regulatory_domain}-${var.product_name}-lbp-03"}"
  image               = "${lookup(data.oci_core_images.ServiceProxyImageOCID.images[0], "id")}"
  shape               = "${var.serviceproxy_instance_shape}"
  hostname_label      = "${(var.region == "us-ashburn-1") ? "ociash1-${var.regulatory_domain}-${var.product_name}-lbp-03" : "ociphx1-${var.regulatory_domain}-${var.product_name}-lbp-03"}"
  preserve_boot_volume = "${var.preserve_boot_volume}"

  create_vnic_details {
    subnet_id = "${(var.control_plane_subnet_access == "private") && (var.dedicated_bastion_subnets == "true") ? "${element(concat(oci_core_subnet.ServiceProxySubnetAD3.*.id,list("")),0)}" : "${element(concat(oci_core_subnet.PublicSubnetAD3.*.id,list("")),0)}"}"
    display_name        = "${(var.region == "us-ashburn-1") ? "ociash1-${var.regulatory_domain}-${var.product_name}-lbp-03" : "ociphx1-${var.regulatory_domain}-${var.product_name}-lbp-03"}"
    hostname_label      = "${(var.region == "us-ashburn-1") ? "ociash1-${var.regulatory_domain}-${var.product_name}-lbp-03" : "ociphx1-${var.regulatory_domain}-${var.product_name}-lbp-03"}"
    assign_public_ip = "true"
    private_ip       = "${var.assign_private_ip == "true" ? cidrhost(lookup(var.network_cidrs,"serviceProxySubnetAD3"), count.index+2) : ""}"
  }

  metadata {
    ssh_authorized_keys = "${var.serviceproxy_instance_ssh_public_key_openssh}"
    # Automate ServiceProxy instance configuration with cloud init run at launch
    user_data = "${base64encode(file("${path.module}/cloud_init/serviceproxy/bootstrap.template.yaml"))}"
  }

  timeouts {
    create = "10m"
  }
}
