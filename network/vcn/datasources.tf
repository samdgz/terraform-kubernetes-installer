# Gets a list of availability domains
data "oci_identity_availability_domains" "ADs" {
  compartment_id = "${var.tenancy_ocid}"
}

# Prevent oci_core_images image list from changing underneath us.
data "oci_core_images" "ImageOCID" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "${var.nat_instance_oracle_linux_image_name}"
}

data "oci_core_images" "ManagementImageOCID" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "${var.management_instance_oracle_linux_image_name}"
}

data "oci_core_images" "BastionImageOCID" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "${var.bastion_instance_oracle_linux_image_name}"
}

data "oci_core_images" "ServiceProxyImageOCID" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "${var.serviceproxy_instance_oracle_linux_image_name}"
}

# Gets a list of VNIC attachments on the NAT instance in AD 1
data "oci_core_vnic_attachments" "NATInstanceAD1Vnics" {
  count               = "${(var.control_plane_subnet_access == "private") && (var.nat_instance_ad1_enabled == "true") ? "1" : "0"}"
  compartment_id      = "${(var.multiple_compartments == "true")  ? var.nat_compartment_ocid : var.compartment_ocid}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  instance_id         = "${oci_core_instance.NATInstanceAD1.id}"
}

# Gets the OCID of the first (default) VNIC on the NAT instance in AD 1
data "oci_core_vnic" "NATInstanceAD1Vnic" {
  count   = "${(var.control_plane_subnet_access == "private") && (var.nat_instance_ad1_enabled == "true") ? "1" : "0"}"
  vnic_id = "${lookup(data.oci_core_vnic_attachments.NATInstanceAD1Vnics.vnic_attachments[0],"vnic_id")}"
}

# List Private IPs on the NAT instance in AD 1
data "oci_core_private_ips" "NATInstanceAD1PrivateIPDatasource" {
  count   = "${(var.control_plane_subnet_access == "private") && (var.nat_instance_ad1_enabled == "true") ? "1" : "0"}"
  vnic_id = "${data.oci_core_vnic.NATInstanceAD1Vnic.id}"
}

# Gets a list of VNIC attachments on the NAT instance in AD 2
data "oci_core_vnic_attachments" "NATInstanceAD2Vnics" {
  count               = "${(var.control_plane_subnet_access == "private") && (var.nat_instance_ad2_enabled == "true") ? "1" : "0"}"
  compartment_id      = "${(var.multiple_compartments == "true")  ? var.nat_compartment_ocid : var.compartment_ocid}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  instance_id         = "${oci_core_instance.NATInstanceAD2.id}"
}

# Gets the OCID of the first (default) VNIC on the NAT instance in AD 2
data "oci_core_vnic" "NATInstanceAD2Vnic" {
  count   = "${(var.control_plane_subnet_access == "private") && (var.nat_instance_ad2_enabled == "true") ? "1" : "0"}"
  vnic_id = "${lookup(data.oci_core_vnic_attachments.NATInstanceAD2Vnics.vnic_attachments[0],"vnic_id")}"
}

# List Private IPs on the NAT instance in AD 2
data "oci_core_private_ips" "NATInstanceAD2PrivateIPDatasource" {
  count   = "${(var.control_plane_subnet_access == "private") && (var.nat_instance_ad2_enabled == "true") ? "1" : "0"}"
  vnic_id = "${data.oci_core_vnic.NATInstanceAD2Vnic.id}"
}

# Gets a list of VNIC attachments on the NAT instance in AD 3
data "oci_core_vnic_attachments" "NATInstanceAD3Vnics" {
  count               = "${(var.control_plane_subnet_access == "private") && (var.nat_instance_ad3_enabled == "true") ? "1" : "0"}"
  compartment_id      = "${(var.multiple_compartments == "true")  ? var.nat_compartment_ocid : var.compartment_ocid}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  instance_id         = "${oci_core_instance.NATInstanceAD3.id}"
}

# Gets the OCID of the first (default) VNIC on the NAT instance in AD 3
data "oci_core_vnic" "NATInstanceAD3Vnic" {
  count   = "${(var.control_plane_subnet_access == "private") && (var.nat_instance_ad3_enabled == "true") ? "1" : "0"}"
  vnic_id = "${lookup(data.oci_core_vnic_attachments.NATInstanceAD3Vnics.vnic_attachments[0],"vnic_id")}"
}

# List Private IPs on the NAT instance in AD 3
data "oci_core_private_ips" "NATInstanceAD3PrivateIPDatasource" {
  count   = "${(var.control_plane_subnet_access == "private") && (var.nat_instance_ad3_enabled == "true") ? "1" : "0"}"
  vnic_id = "${data.oci_core_vnic.NATInstanceAD3Vnic.id}"
}

data "template_file" "management-setup-template" {
  template = "${file("${path.module}/scripts/management/setup.template.sh")}"

  vars = {
    domain_name        = "${var.domain_name}"
    docker_ver         = "${var.docker_ver}"
    flannel_ver        = "${var.flannel_ver}"
    docker_max_log_size = "${var.management_docker_max_log_size}"
    docker_max_log_files = "${var.management_docker_max_log_files}"
    etcd_endpoints     = "${var.etcd_endpoints}"
    reverse_proxy_setup       = "${var.reverse_proxy_setup}"
  }
}

data "template_file" "management-setup-preflight" {
  template = "${file("${path.module}/scripts/management/setup.preflight.sh")}"
}

data "template_file" "flannel-service" {
  template = "${file("${path.module}/scripts/management/flannel.service")}"
}

data "template_file" "cnibridge-service" {
  template = "${file("${path.module}/scripts/management/cni-bridge.service")}"
}

data "template_file" "cnibridge-sh" {
  template = "${file("${path.module}/scripts/management/cni-bridge.sh")}"
}

data "template_file" "management_cloud_init_file" {
  template = "${file("${path.module}/cloud_init/management/bootstrap.template.yaml")}"

  vars = {
    setup_preflight_sh_content = "${base64encode(data.template_file.management-setup-preflight.rendered)}"
    setup_template_sh_content  = "${base64encode(data.template_file.management-setup-template.rendered)}"
    flannel_service_content    = "${base64encode(data.template_file.flannel-service.rendered)}"
    cnibridge_service_content  = "${base64encode(data.template_file.cnibridge-service.rendered)}"
    cnibridge_sh_content       = "${base64encode(data.template_file.cnibridge-sh.rendered)}"
    reverse_proxy-content      = "${var.reverse_proxy_clount_init}"
  }
}

data "template_cloudinit_config" "management" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "bootstrap.yaml"
    content_type = "text/cloud-config"
    content      = "${data.template_file.management_cloud_init_file.rendered}"
  }
}
