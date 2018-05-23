#TODO https://github.com/hashicorp/terraform/issues/11566

resource "oci_core_subnet" "PublicSubnetAD1" {
  # Provisioned only when k8s instances are in private subnets
  count               = "${var.control_plane_subnet_access == "private" ? "1" : "0"}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block          = "10.0.10.0/24"
  display_name        = "${var.label_prefix}publicSubnetAD1"
  compartment_id      = "${(var.multiple_compartments == "true")  ? var.lb_compartment_ocid : var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.CompleteVCN.id}"
  route_table_id      = "${oci_core_route_table.PublicRouteTable.id}"
  security_list_ids   = ["${concat(list(oci_core_security_list.GlobalSecurityList.id),list(oci_core_security_list.PublicSecurityList.id), var.additional_public_security_lists_ids)}"]
  dhcp_options_id     = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"
}

resource "oci_core_subnet" "PublicSubnetAD2" {
  count               = "${var.control_plane_subnet_access == "private" ? "1" : "0"}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  cidr_block          = "10.0.11.0/24"
  display_name        = "${var.label_prefix}publicSubnetAD2"
  compartment_id      = "${(var.multiple_compartments == "true")  ? var.lb_compartment_ocid : var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.CompleteVCN.id}"
  route_table_id      = "${oci_core_route_table.PublicRouteTable.id}"
  security_list_ids   = ["${concat(list(oci_core_security_list.GlobalSecurityList.id),list(oci_core_security_list.PublicSecurityList.id), var.additional_public_security_lists_ids)}"]
  dhcp_options_id     = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"
}

resource "oci_core_subnet" "PublicSubnetAD3" {
  count               = "${var.control_plane_subnet_access == "private" ? "1" : "0"}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  cidr_block          = "10.0.12.0/24"
  display_name        = "${var.label_prefix}publicSubnetAD3"
  compartment_id      = "${(var.multiple_compartments == "true")  ? var.lb_compartment_ocid : var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.CompleteVCN.id}"
  route_table_id      = "${oci_core_route_table.PublicRouteTable.id}"
  security_list_ids   = ["${concat(list(oci_core_security_list.GlobalSecurityList.id),list(oci_core_security_list.PublicSecurityList.id), var.additional_public_security_lists_ids)}"]
  dhcp_options_id     = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"
}

resource "oci_core_subnet" "NATSubnetAD1" {
  # Provisioned only when k8s instances are in private subnets
  count               = "${(var.control_plane_subnet_access == "private") && (var.dedicated_nat_subnets == "true") ? "1" : 
"0"}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block          = "${lookup(var.network_cidrs, "natSubnetAD1")}"
  display_name        = "${var.label_prefix}publicNATSubnetAD1"
  compartment_id      = "${(var.multiple_compartments == "true")  ? var.nat_compartment_ocid : var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.CompleteVCN.id}"
  route_table_id      = "${oci_core_route_table.PublicRouteTable.id}"
  security_list_ids   = ["${concat(list(oci_core_security_list.GlobalSecurityList.id),list(oci_core_security_list.NatSecurityList.id), var.additional_nat_security_lists_ids)}"]
  dhcp_options_id     = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"
}

resource "oci_core_subnet" "NATSubnetAD2" {
  count               = "${(var.control_plane_subnet_access == "private") && (var.dedicated_nat_subnets == "true") ? "1" : 
"0"}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  cidr_block          = "${lookup(var.network_cidrs, "natSubnetAD2")}"
  display_name        = "${var.label_prefix}publicNATSubnetAD2"
  compartment_id      = "${(var.multiple_compartments == "true")  ? var.nat_compartment_ocid : var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.CompleteVCN.id}"
  route_table_id      = "${oci_core_route_table.PublicRouteTable.id}"
  security_list_ids   = ["${concat(list(oci_core_security_list.GlobalSecurityList.id),list(oci_core_security_list.NatSecurityList.id), var.additional_nat_security_lists_ids)}"]
  dhcp_options_id     = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"
}

resource "oci_core_subnet" "NATSubnetAD3" {
  count               = "${(var.control_plane_subnet_access == "private") && (var.dedicated_nat_subnets == "true") ? "1" : 
"0"}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  cidr_block          = "${lookup(var.network_cidrs, "natSubnetAD3")}"
  display_name        = "${var.label_prefix}publicNATSubnetAD3"
  compartment_id      = "${(var.multiple_compartments == "true")  ? var.nat_compartment_ocid : var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.CompleteVCN.id}"
  route_table_id      = "${oci_core_route_table.PublicRouteTable.id}"
  security_list_ids   = ["${concat(list(oci_core_security_list.GlobalSecurityList.id),list(oci_core_security_list.NatSecurityList.id), var.additional_nat_security_lists_ids)}"]
  dhcp_options_id     = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"
}

resource "oci_core_subnet" "BastionSubnetAD1" {
  # Provisioned only when k8s instances are in private subnets
  count               = "${(var.control_plane_subnet_access == "private") && (var.dedicated_bastion_subnets == "true") ? "1" : "0"}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block          = "${lookup(var.network_cidrs, "bastionSubnetAD1")}"
  display_name        = "${var.label_prefix}publicBastionSubnetAD1"
  dns_label           = "bastionsubnet1"
  compartment_id      = "${(var.multiple_compartments == "true")  ? var.bastion_compartment_ocid : var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.CompleteVCN.id}"
  route_table_id      = "${oci_core_route_table.PublicRouteTable.id}"
  security_list_ids   = ["${concat(list(oci_core_security_list.GlobalSecurityList.id),list(oci_core_security_list.BastionSecurityList.id), var.additional_bastion_security_lists_ids)}"]
  dhcp_options_id     = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"
}

resource "oci_core_subnet" "BastionSubnetAD2" {
  count               = "${(var.control_plane_subnet_access == "private") && (var.dedicated_bastion_subnets == "true") ? "1" : "0"}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  cidr_block          = "${lookup(var.network_cidrs, "bastionSubnetAD2")}"
  display_name        = "${var.label_prefix}publicBastionSubnetAD2"
  dns_label           = "bastionsubnet2"
  compartment_id      = "${(var.multiple_compartments == "true")  ? var.bastion_compartment_ocid : var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.CompleteVCN.id}"
  route_table_id      = "${oci_core_route_table.PublicRouteTable.id}"
  security_list_ids   = ["${concat(list(oci_core_security_list.GlobalSecurityList.id),list(oci_core_security_list.BastionSecurityList.id), var.additional_bastion_security_lists_ids)}"]
  dhcp_options_id     = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"
}

resource "oci_core_subnet" "BastionSubnetAD3" {
  count               = "${(var.control_plane_subnet_access == "private") && (var.dedicated_bastion_subnets == "true") ? "1" : "0"}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  cidr_block          = "${lookup(var.network_cidrs, "bastionSubnetAD3")}"
  display_name        = "${var.label_prefix}publicBastionSubnetAD3"
  dns_label           = "bastionsubnet3"
  compartment_id      = "${(var.multiple_compartments == "true")  ? var.bastion_compartment_ocid : var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.CompleteVCN.id}"
  route_table_id      = "${oci_core_route_table.PublicRouteTable.id}"
  security_list_ids   = ["${concat(list(oci_core_security_list.GlobalSecurityList.id),list(oci_core_security_list.BastionSecurityList.id), var.additional_bastion_security_lists_ids)}"]
  dhcp_options_id     = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"
}

resource "oci_core_subnet" "ManagementSubnetAD1" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block          = "${lookup(var.network_cidrs, "managementSubnetAD1")}"
  compartment_id      = "${(var.multiple_compartments == "true")  ? var.bastion_compartment_ocid : var.compartment_ocid
}"
  display_name        = "${var.label_prefix}${var.control_plane_subnet_access}ManagementSubnetAD1"
  dns_label           = "mgmtsubnet1"
  vcn_id              = "${oci_core_virtual_network.CompleteVCN.id}"

  # Work around HIL issue #50 using join and use coalesce to pick the first route that is not empty (AD1 first pick)
  route_table_id             = "${var.control_plane_subnet_access == "private" ? coalesce(join(" ", oci_core_route_table.NATInstanceAD1RouteTable.*.id), join(" ", oci_core_route_table.NATInstanceAD2RouteTable.*.id), join(" ", oci_core_route_table.NATInstanceAD3RouteTable.*.id), oci_core_route_table.PublicRouteTable.id) : oci_core_route_table.PublicRouteTable.id}"
  dhcp_options_id            = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"
  security_list_ids          = ["${concat(list(oci_core_security_list.GlobalSecurityList.id),list(oci_core_security_list.ManagementSecurityList.id), var.additional_management_security_lists_ids)}"]
  prohibit_public_ip_on_vnic = "${var.control_plane_subnet_access == "private" ? "true" : "false"}"

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_subnet" "ManagementSubnetAD2" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  cidr_block          = "${lookup(var.network_cidrs, "managementSubnetAD2")}"
  compartment_id      = "${(var.multiple_compartments == "true")  ? var.bastion_compartment_ocid : var.compartment_ocid
}"
  display_name        = "${var.label_prefix}${var.control_plane_subnet_access}ManagementSubnetAD2"
  dns_label           = "mgmtsubnet2"
  vcn_id              = "${oci_core_virtual_network.CompleteVCN.id}"

  # Work around HIL issue #50 using join and use coalesce to pick the first route that is not empty (AD1 first pick)
  route_table_id             = "${var.control_plane_subnet_access == "private" ? coalesce(join(" ", oci_core_route_table.NATInstanceAD2RouteTable.*.id), join(" ", oci_core_route_table.NATInstanceAD1RouteTable.*.id), join(" ", oci_core_route_table.NATInstanceAD3RouteTable.*.id), oci_core_route_table.PublicRouteTable.id) : oci_core_route_table.PublicRouteTable.id}"
  dhcp_options_id            = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"
  security_list_ids          = ["${concat(list(oci_core_security_list.GlobalSecurityList.id),list(oci_core_security_list.ManagementSecurityList.id), var.additional_management_security_lists_ids)}"]
  prohibit_public_ip_on_vnic = "${var.control_plane_subnet_access == "private" ? "true" : "false"}"

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_subnet" "ManagementSubnetAD3" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  cidr_block          = "${lookup(var.network_cidrs, "managementSubnetAD3")}"
  compartment_id      = "${(var.multiple_compartments == "true")  ? var.bastion_compartment_ocid : var.compartment_ocid
}"
  display_name        = "${var.label_prefix}${var.control_plane_subnet_access}ManagementSubnetAD3"
  dns_label           = "mgmtsubnet3"
  vcn_id              = "${oci_core_virtual_network.CompleteVCN.id}"

  # Work around HIL issue #50 using join and use coalesce to pick the first route that is not empty (AD1 first pick)
  route_table_id             = "${var.control_plane_subnet_access == "private" ? coalesce(join(" ", oci_core_route_table.NATInstanceAD3RouteTable.*.id), join(" ", oci_core_route_table.NATInstanceAD2RouteTable.*.id), join(" ", oci_core_route_table.NATInstanceAD1RouteTable.*.id), oci_core_route_table.PublicRouteTable.id) : oci_core_route_table.PublicRouteTable.id}"
  dhcp_options_id            = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"
  security_list_ids          = ["${concat(list(oci_core_security_list.GlobalSecurityList.id),list(oci_core_security_list.ManagementSecurityList.id), var.additional_management_security_lists_ids)}"]
  prohibit_public_ip_on_vnic = "${var.control_plane_subnet_access == "private" ? "true" : "false"}"

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_subnet" "etcdSubnetAD1" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block          = "10.0.20.0/24"
  compartment_id      = "${(var.multiple_compartments == "true")  ? var.coreservice_compartment_ocid : var.compartment_ocid
}"
  display_name        = "${var.label_prefix}${var.control_plane_subnet_access}ETCDSubnetAD1"
  dns_label           = "etcdsubnet1"
  vcn_id              = "${oci_core_virtual_network.CompleteVCN.id}"

  # Work around HIL issue #50 using join and use coalesce to pick the first route that is not empty (AD1 first pick)
  route_table_id             = "${var.control_plane_subnet_access == "private" ? coalesce(join(" ", oci_core_route_table.NATInstanceAD1RouteTable.*.id), join(" ", oci_core_route_table.NATInstanceAD2RouteTable.*.id), join(" ", oci_core_route_table.NATInstanceAD3RouteTable.*.id), oci_core_route_table.PublicRouteTable.id) : oci_core_route_table.PublicRouteTable.id}"
  dhcp_options_id            = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"
  security_list_ids          = ["${concat(list(oci_core_security_list.GlobalSecurityList.id),list(oci_core_security_list.EtcdSubnet.id), var.additional_etcd_security_lists_ids)}"]
  prohibit_public_ip_on_vnic = "${var.control_plane_subnet_access == "private" ? "true" : "false"}"

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_subnet" "etcdSubnetAD2" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  cidr_block          = "10.0.21.0/24"
  compartment_id      = "${(var.multiple_compartments == "true")  ? var.coreservice_compartment_ocid : var.compartment_ocid
}"
  display_name        = "${var.label_prefix}${var.control_plane_subnet_access}ETCDSubnetAD2"
  dns_label           = "etcdsubnet2"
  vcn_id              = "${oci_core_virtual_network.CompleteVCN.id}"

  # Work around HIL issue #50 using join and use coalesce to pick the first route that is not empty (AD2 first pick)
  route_table_id             = "${var.control_plane_subnet_access == "private" ? coalesce(join(" ", oci_core_route_table.NATInstanceAD2RouteTable.*.id), join(" ", oci_core_route_table.NATInstanceAD1RouteTable.*.id), join(" ", oci_core_route_table.NATInstanceAD3RouteTable.*.id), oci_core_route_table.PublicRouteTable.id) : oci_core_route_table.PublicRouteTable.id}"
  dhcp_options_id            = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"
  security_list_ids          = ["${concat(list(oci_core_security_list.GlobalSecurityList.id),list(oci_core_security_list.EtcdSubnet.id), var.additional_etcd_security_lists_ids)}"]
  prohibit_public_ip_on_vnic = "${var.control_plane_subnet_access == "private" ? "true" : "false"}"

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_subnet" "etcdSubnetAD3" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  cidr_block          = "10.0.22.0/24"
  compartment_id      = "${(var.multiple_compartments == "true")  ? var.coreservice_compartment_ocid : var.compartment_ocid
}"
  display_name        = "${var.label_prefix}${var.control_plane_subnet_access}ETCDSubnetAD3"
  dns_label           = "etcdsubnet3"
  vcn_id              = "${oci_core_virtual_network.CompleteVCN.id}"

  # Work around HIL issue #50 using join and use coalesce to pick the first route that is not empty (AD3 first pick)
  route_table_id             = "${var.control_plane_subnet_access == "private" ? coalesce(join(" ", oci_core_route_table.NATInstanceAD3RouteTable.*.id), join(" ", oci_core_route_table.NATInstanceAD1RouteTable.*.id), join(" ", oci_core_route_table.NATInstanceAD2RouteTable.*.id), oci_core_route_table.PublicRouteTable.id) : oci_core_route_table.PublicRouteTable.id}"
  dhcp_options_id            = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"
  security_list_ids          = ["${concat(list(oci_core_security_list.GlobalSecurityList.id),list(oci_core_security_list.EtcdSubnet.id), var.additional_etcd_security_lists_ids)}"]
  prohibit_public_ip_on_vnic = "${var.control_plane_subnet_access == "private" ? "true" : "false"}"

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_subnet" "k8sMasterSubnetAD1" {
  availability_domain        = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block                 = "10.0.30.0/24"
  compartment_id             = "${(var.multiple_compartments == "true")  ? var.coreservice_compartment_ocid : var.compartment_ocid}"
  display_name               = "${var.label_prefix}${var.control_plane_subnet_access}K8SMasterSubnetAD1"
  dns_label                  = "k8smasterad1"
  vcn_id                     = "${oci_core_virtual_network.CompleteVCN.id}"
  route_table_id             = "${var.control_plane_subnet_access == "private" ? coalesce(join(" ", oci_core_route_table.NATInstanceAD1RouteTable.*.id), join(" ", oci_core_route_table.NATInstanceAD2RouteTable.*.id), join(" ", oci_core_route_table.NATInstanceAD3RouteTable.*.id), oci_core_route_table.PublicRouteTable.id) : oci_core_route_table.PublicRouteTable.id}"
  dhcp_options_id            = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"
  security_list_ids          = ["${concat(list(oci_core_security_list.GlobalSecurityList.id),list(oci_core_security_list.K8SMasterSubnet.id), var.additional_k8smaster_security_lists_ids)}"]
  prohibit_public_ip_on_vnic = "${var.control_plane_subnet_access == "private" ? "true" : "false"}"

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_subnet" "k8sMasterSubnetAD2" {
  availability_domain        = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  cidr_block                 = "10.0.31.0/24"
  compartment_id             = "${(var.multiple_compartments == "true")  ? var.coreservice_compartment_ocid : var.compartment_ocid}"
  display_name               = "${var.label_prefix}${var.control_plane_subnet_access}K8SMasterSubnetAD2"
  dns_label                  = "k8smasterad2"
  vcn_id                     = "${oci_core_virtual_network.CompleteVCN.id}"
  route_table_id             = "${var.control_plane_subnet_access == "private" ? coalesce(join(" ", oci_core_route_table.NATInstanceAD2RouteTable.*.id), join(" ", oci_core_route_table.NATInstanceAD1RouteTable.*.id), join(" ", oci_core_route_table.NATInstanceAD3RouteTable.*.id), oci_core_route_table.PublicRouteTable.id) : oci_core_route_table.PublicRouteTable.id}"
  dhcp_options_id            = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"
  security_list_ids          = ["${concat(list(oci_core_security_list.GlobalSecurityList.id),list(oci_core_security_list.K8SMasterSubnet.id), var.additional_k8smaster_security_lists_ids)}"]
  prohibit_public_ip_on_vnic = "${var.control_plane_subnet_access == "private" ? "true" : "false"}"

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_subnet" "k8sMasterSubnetAD3" {
  availability_domain        = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  cidr_block                 = "10.0.32.0/24"
  compartment_id             = "${(var.multiple_compartments == "true")  ? var.coreservice_compartment_ocid : var.compartment_ocid}"
  display_name               = "${var.label_prefix}${var.control_plane_subnet_access}K8SMasterSubnetAD3"
  dns_label                  = "k8smasterad3"
  vcn_id                     = "${oci_core_virtual_network.CompleteVCN.id}"
  route_table_id             = "${var.control_plane_subnet_access == "private" ? coalesce(join(" ", oci_core_route_table.NATInstanceAD3RouteTable.*.id), join(" ", oci_core_route_table.NATInstanceAD1RouteTable.*.id), join(" ", oci_core_route_table.NATInstanceAD2RouteTable.*.id), oci_core_route_table.PublicRouteTable.id) : oci_core_route_table.PublicRouteTable.id}"
  dhcp_options_id            = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"
  security_list_ids          = ["${concat(list(oci_core_security_list.GlobalSecurityList.id),list(oci_core_security_list.K8SMasterSubnet.id), var.additional_k8smaster_security_lists_ids)}"]
  prohibit_public_ip_on_vnic = "${var.control_plane_subnet_access == "private" ? "true" : "false"}"

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_subnet" "k8sWorkerSubnetAD1" {
  availability_domain        = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block                 = "10.0.40.0/24"
  compartment_id             = "${(var.multiple_compartments == "true")  ? var.coreservice_compartment_ocid : var.compartment_ocid}"
  display_name               = "${var.label_prefix}${var.control_plane_subnet_access}K8SWorkerSubnetAD1"
  dns_label                  = "k8sworkerad1"
  vcn_id                     = "${oci_core_virtual_network.CompleteVCN.id}"
  route_table_id             = "${var.control_plane_subnet_access == "private" ? coalesce(join(" ", oci_core_route_table.NATInstanceAD1RouteTable.*.id), join(" ", oci_core_route_table.NATInstanceAD2RouteTable.*.id), join(" ", oci_core_route_table.NATInstanceAD3RouteTable.*.id), oci_core_route_table.PublicRouteTable.id) : oci_core_route_table.PublicRouteTable.id}"
  dhcp_options_id            = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"
  security_list_ids          = ["${concat(list(oci_core_security_list.GlobalSecurityList.id),list(oci_core_security_list.K8SWorkerSubnet.id), var.additional_k8sworker_security_lists_ids)}"]
  prohibit_public_ip_on_vnic = "${var.control_plane_subnet_access == "private" ? "true" : "false"}"

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_subnet" "k8sWorkerSubnetAD2" {
  availability_domain        = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  cidr_block                 = "10.0.41.0/24"
  compartment_id             = "${(var.multiple_compartments == "true")  ? var.coreservice_compartment_ocid : var.compartment_ocid}"
  display_name               = "${var.label_prefix}${var.control_plane_subnet_access}K8SWorkerSubnetAD2"
  dns_label                  = "k8sworkerad2"
  vcn_id                     = "${oci_core_virtual_network.CompleteVCN.id}"
  route_table_id             = "${var.control_plane_subnet_access == "private" ? coalesce(join(" ", oci_core_route_table.NATInstanceAD2RouteTable.*.id), join(" ", oci_core_route_table.NATInstanceAD1RouteTable.*.id), join(" ", oci_core_route_table.NATInstanceAD3RouteTable.*.id), oci_core_route_table.PublicRouteTable.id) : oci_core_route_table.PublicRouteTable.id}"
  dhcp_options_id            = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"
  security_list_ids          = ["${concat(list(oci_core_security_list.GlobalSecurityList.id),list(oci_core_security_list.K8SWorkerSubnet.id), var.additional_k8sworker_security_lists_ids)}"]
  prohibit_public_ip_on_vnic = "${var.control_plane_subnet_access == "private" ? "true" : "false"}"

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_subnet" "k8sWorkerSubnetAD3" {
  availability_domain        = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  cidr_block                 = "10.0.42.0/24"
  compartment_id             = "${(var.multiple_compartments == "true")  ? var.coreservice_compartment_ocid : var.compartment_ocid}"
  display_name               = "${var.label_prefix}${var.control_plane_subnet_access}K8SWorkerSubnetAD3"
  dns_label                  = "k8sworkerad3"
  vcn_id                     = "${oci_core_virtual_network.CompleteVCN.id}"
  route_table_id             = "${var.control_plane_subnet_access == "private" ? coalesce(join(" ", oci_core_route_table.NATInstanceAD3RouteTable.*.id), join(" ", oci_core_route_table.NATInstanceAD1RouteTable.*.id), join(" ", oci_core_route_table.NATInstanceAD2RouteTable.*.id), oci_core_route_table.PublicRouteTable.id) : oci_core_route_table.PublicRouteTable.id}"
  dhcp_options_id            = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"
  security_list_ids          = ["${concat(list(oci_core_security_list.GlobalSecurityList.id),list(oci_core_security_list.K8SWorkerSubnet.id), var.additional_k8sworker_security_lists_ids)}"]
  prohibit_public_ip_on_vnic = "${var.control_plane_subnet_access == "private" ? "true" : "false"}"

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_subnet" "ServiceProxySubnetAD1" {
  # Provisioned only when k8s instances are in private subnets
  count               = "${(var.control_plane_subnet_access == "private") && (var.dedicated_bastion_subnets == "true") ? "1" : "0"}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block          = "${lookup(var.network_cidrs, "serviceProxySubnetAD1")}"
  display_name        = "${var.label_prefix}publicServiceProxySubnetAD1"
  dns_label           = "lbpsubnet1"
  compartment_id      = "${(var.multiple_compartments == "true")  ? var.bastion_compartment_ocid : var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.CompleteVCN.id}"
  route_table_id      = "${oci_core_route_table.PublicRouteTable.id}"
  security_list_ids   = ["${concat(list(oci_core_security_list.GlobalSecurityList.id),list(oci_core_security_list.ServiceProxySecurityList.id), var.additional_serviceproxy_security_lists_ids)}"]
  dhcp_options_id     = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"
}

resource "oci_core_subnet" "ServiceProxySubnetAD2" {
  count               = "${(var.control_plane_subnet_access == "private") && (var.dedicated_bastion_subnets == "true") ? "1" : "0"}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  cidr_block          = "${lookup(var.network_cidrs, "serviceProxySubnetAD2")}"
  display_name        = "${var.label_prefix}publicServiceProxySubnetAD2"
  dns_label           = "lbpsubnet2"
  compartment_id      = "${(var.multiple_compartments == "true")  ? var.bastion_compartment_ocid : var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.CompleteVCN.id}"
  route_table_id      = "${oci_core_route_table.PublicRouteTable.id}"
  security_list_ids   = ["${concat(list(oci_core_security_list.GlobalSecurityList.id),list(oci_core_security_list.ServiceProxySecurityList.id), var.additional_serviceproxy_security_lists_ids)}"]
  dhcp_options_id     = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"
}

resource "oci_core_subnet" "ServiceProxySubnetAD3" {
  count               = "${(var.control_plane_subnet_access == "private") && (var.dedicated_bastion_subnets == "true") ? "1" : "0"}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  cidr_block          = "${lookup(var.network_cidrs, "serviceProxySubnetAD3")}"
  display_name        = "${var.label_prefix}publicServiceProxySubnetAD3"
  dns_label           = "lbpsubnet3"
  compartment_id      = "${(var.multiple_compartments == "true")  ? var.bastion_compartment_ocid : var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.CompleteVCN.id}"
  route_table_id      = "${oci_core_route_table.PublicRouteTable.id}"
  security_list_ids   = ["${concat(list(oci_core_security_list.GlobalSecurityList.id),list(oci_core_security_list.ServiceProxySecurityList.id), var.additional_serviceproxy_security_lists_ids)}"]
  dhcp_options_id     = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"
}
