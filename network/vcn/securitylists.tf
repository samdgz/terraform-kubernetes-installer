resource "oci_core_security_list" "EtcdSubnet" {
  compartment_id = "${(var.multiple_compartments == "true")  ? var.coreservice_compartment_ocid : var.compartment_ocid}"
  display_name   = "${var.label_prefix}EtcdSeclist"
  vcn_id         = "${oci_core_virtual_network.CompleteVCN.id}"

  egress_security_rules = [
    {
      destination = "0.0.0.0/0"
      protocol    = "all"
    },
  ]

  ingress_security_rules = [
    {
      tcp_options {
        "max" = 2380
        "min" = 2379
      }

      protocol = "6"
      source   = "10.0.20.0/24"
    },
    {
      tcp_options {
        "max" = 2380
        "min" = 2379
      }

      protocol = "6"
      source   = "10.0.21.0/24"
    },
    {
      tcp_options {
        "max" = 2380
        "min" = 2379
      }

      protocol = "6"
      source   = "10.0.22.0/24"
    },
    {
      tcp_options {
        "max" = 2380
        "min" = 2379
      }

      protocol = "6"
      source   = "10.0.30.0/24"
    },
    {
      tcp_options {
        "max" = 2380
        "min" = 2379
      }

      protocol = "6"
      source   = "10.0.31.0/24"
    },
    {
      tcp_options {
        "max" = 2380
        "min" = 2379
      }

      protocol = "6"
      source   = "10.0.32.0/24"
    },
    {
      tcp_options {
        "max" = 2380
        "min" = 2379
      }

      protocol = "6"
      source   = "10.0.40.0/24"
    },
    {
      tcp_options {
        "max" = 2380
        "min" = 2379
      }

      protocol = "6"
      source   = "10.0.41.0/24"
    },
    {
      tcp_options {
        "max" = 2380
        "min" = 2379
      }

      protocol = "6"
      source   = "10.0.42.0/24"
    },
    {
      tcp_options {
        "max" = 9102
        "min" = 9102
      }

      protocol = "6"
      source   = "10.0.40.0/24"
    },
    {
      tcp_options {
        "max" = 9102
        "min" = 9102
      }

      protocol = "6"
      source   = "10.0.41.0/24"
    },
    {
      tcp_options {
        "max" = 9102
        "min" = 9102
      }

      protocol = "6"
      source   = "10.0.42.0/24"
    },
    {
      tcp_options {
        "max" = 9323
        "min" = 9323
      }

      protocol = "6"
      source   = "10.0.40.0/24"
    },
    {
      tcp_options {
        "max" = 9323
        "min" = 9323
      }

      protocol = "6"
      source   = "10.0.41.0/24"
    },
    {
      tcp_options {
        "max" = 9323
        "min" = 9323
      }

      protocol = "6"
      source   = "10.0.42.0/24"
    },
  ]

  lifecycle {
    ignore_changes = ["egress_security_rules","ingress_security_rules"]
  }

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_security_list" "K8SMasterSubnet" {
  compartment_id = "${(var.multiple_compartments == "true")  ? var.coreservice_compartment_ocid : var.compartment_ocid}"
  display_name   = "${var.label_prefix}MasterSeclist"
  vcn_id         = "${oci_core_virtual_network.CompleteVCN.id}"

  egress_security_rules = [
    {
      destination = "0.0.0.0/0"
      protocol    = "all"
    },
  ]

  ingress_security_rules = [
    {
      tcp_options {
        "max" = 443
        "min" = 443
      }

      protocol = "6"
      source   = "10.0.60.0/24"
    },
    {
      tcp_options {
        "max" = 443
        "min" = 443
      }

      protocol = "6"
      source   = "10.0.61.0/24"
    },
    {
      tcp_options {
        "max" = 443
        "min" = 443
      }

      protocol = "6"
      source   = "10.0.62.0/24"
    },
    {
      udp_options {
        "max" = 8472
        "min" = 8472
      }

      protocol = "17"
      source   = "10.0.30.0/24"
    },
    {
      udp_options {
        "max" = 8472
        "min" = 8472
      }

      protocol = "17"
      source   = "10.0.31.0/24"
    },
    {
      udp_options {
        "max" = 8472
        "min" = 8472
      }

      protocol = "17"
      source   = "10.0.32.0/24"
    },
    {
      tcp_options {
        "max" = 10250
        "min" = 10250
      }

      protocol = "6"
      source   = "10.0.30.0/24"
    },
    {
      tcp_options {
        "max" = 10250
        "min" = 10250
      }

      protocol = "6"
      source   = "10.0.31.0/24"
    },
    {
      tcp_options {
        "max" = 10250
        "min" = 10250
      }

      protocol = "6"
      source   = "10.0.32.0/24"
    },
    {
      tcp_options {
        "max" = 443
        "min" = 443
      }

      protocol = "6"
      source   = "10.0.40.0/24"
    },
    {
      tcp_options {
        "max" = 443
        "min" = 443
      }

      protocol = "6"
      source   = "10.0.41.0/24"
    },
    {
      tcp_options {
        "max" = 443
        "min" = 443
      }

      protocol = "6"
      source   = "10.0.42.0/24"
    },
    {
      udp_options {
        "max" = 8472
        "min" = 8472
      }

      protocol = "17"
      source   = "10.0.40.0/24"
    },
    {
      udp_options {
        "max" = 8472
        "min" = 8472
      }

      protocol = "17"
      source   = "10.0.41.0/24"
    },
    {
      udp_options {
        "max" = 8472
        "min" = 8472
      }

      protocol = "17"
      source   = "10.0.42.0/24"
    },
    {
      tcp_options {
        "max" = 9102
        "min" = 9102
      }

      protocol = "6"
      source   = "10.0.40.0/24"
    },
    {
      tcp_options {
        "max" = 9102
        "min" = 9102
      }

      protocol = "6"
      source   = "10.0.41.0/24"
    },
    {
      tcp_options {
        "max" = 9102
        "min" = 9102
      }

      protocol = "6"
      source   = "10.0.42.0/24"
    },
    {
      tcp_options {
        "max" = 9323
        "min" = 9323
      }
 
      protocol = "6"
      source   = "10.0.40.0/24"
    },
    {
      tcp_options {
        "max" = 9323
        "min" = 9323
      }

      protocol = "6"
      source   = "10.0.41.0/24"
    },
    {
      tcp_options {
        "max" = 9323
        "min" = 9323
      }

      protocol = "6"
      source   = "10.0.42.0/24"
    },
    {
      tcp_options {
        "max" = 10250
        "min" = 10250
      }

      protocol = "6"
      source   = "10.0.40.0/24"
    },
    {
      tcp_options {
        "max" = 10250
        "min" = 10250
      }

      protocol = "6"
      source   = "10.0.41.0/24"
    },
    {
      tcp_options {
        "max" = 10250
        "min" = 10250
      }

      protocol = "6"
      source   = "10.0.42.0/24"
    },
  ]

  lifecycle {
    ignore_changes = ["egress_security_rules","ingress_security_rules"]
  }

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_security_list" "K8SWorkerSubnet" {
  compartment_id = "${(var.multiple_compartments == "true")  ? var.coreservice_compartment_ocid : var.compartment_ocid}"
  display_name   = "${var.label_prefix}WorkerSeclist"
  vcn_id         = "${oci_core_virtual_network.CompleteVCN.id}"

  egress_security_rules = [
    {
      destination = "0.0.0.0/0"
      protocol    = "all"
    },
  ]

  ingress_security_rules = [
    {
      tcp_options {
        "min" = 32002
        "max" = 32002
      }

      protocol = "6"
      source   = "10.0.10.0/24"
    },
    {
      tcp_options {
        "min" = 32002
        "max" = 32002
      }

      protocol = "6"
      source   = "10.0.11.0/24"
    },
    {
      tcp_options {
        "min" = 32002
        "max" = 32002
      }

      protocol = "6"
      source   = "10.0.12.0/24"
    },
    {
      tcp_options {
        "max" = 32003
        "min" = 32000
      }

      protocol = "6"
      source   = "10.0.60.0/24"
    },
    {
      tcp_options {
        "max" = 32003
        "min" = 32000
      }

      protocol = "6"
      source   = "10.0.61.0/24"
    },
    {
      tcp_options {
        "max" = 32003
        "min" = 32000
      }

      protocol = "6"
      source   = "10.0.62.0/24"
    },
    {
      udp_options {
        "max" = 8472
        "min" = 8472
      }

      protocol = "17"
      source   = "10.0.30.0/24"
    },
    {
      udp_options {
        "max" = 8472
        "min" = 8472
      }

      protocol = "17"
      source   = "10.0.31.0/24"
    },
    {
      udp_options {
        "max" = 8472
        "min" = 8472
      }

      protocol = "17"
      source   = "10.0.32.0/24"
    },
    {
      tcp_options {
        "max" = 10250
        "min" = 10250
      }

      protocol = "6"
      source   = "10.0.30.0/24"
    },
    {
      tcp_options {
        "max" = 10250
        "min" = 10250
      }

      protocol = "6"
      source   = "10.0.31.0/24"
    },
    {
      tcp_options {
        "max" = 10250
        "min" = 10250
      }

      protocol = "6"
      source   = "10.0.32.0/24"
    },
    {
      udp_options {
        "max" = 8472
        "min" = 8472
      }

      protocol = "17"
      source   = "10.0.40.0/24"
    },
    {
      udp_options {
        "max" = 8472
        "min" = 8472
      }

      protocol = "17"
      source   = "10.0.41.0/24"
    },
    {
      udp_options {
        "max" = 8472
        "min" = 8472
      }

      protocol = "17"
      source   = "10.0.42.0/24"
    },
    {
      tcp_options {
        "max" = 9102
        "min" = 9102
      }

      protocol = "6"
      source   = "10.0.40.0/24"
    },
    {
      tcp_options {
        "max" = 9102
        "min" = 9102
      }

      protocol = "6"
      source   = "10.0.41.0/24"
    },
    {
      tcp_options {
        "max" = 9102
        "min" = 9102
      }

      protocol = "6"
      source   = "10.0.42.0/24"
    },
    {
      tcp_options {
        "max" = 9323
        "min" = 9323
      }
 
      protocol = "6"
      source   = "10.0.40.0/24"
    },
    {
      tcp_options {
        "max" = 9323
        "min" = 9323
      }

      protocol = "6"
      source   = "10.0.41.0/24"
    },
    {
      tcp_options {
        "max" = 9323
        "min" = 9323
      }

      protocol = "6"
      source   = "10.0.42.0/24"
    },
  ]

  lifecycle {
    ignore_changes = ["egress_security_rules","ingress_security_rules"]
  }

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_security_list" "PublicSecurityList" {
  count          = "${var.control_plane_subnet_access == "private" ? "1" : "0"}"
  compartment_id = "${(var.multiple_compartments == "true")  ? var.lb_compartment_ocid : var.compartment_ocid}"
  display_name   = "LBSeclist"
  vcn_id         = "${oci_core_virtual_network.CompleteVCN.id}"

  egress_security_rules = [    
    {
      protocol = "6"
      destination = "10.0.40.0/22"

      tcp_options {
        "min" = 32002
        "max" = 32002
      }
    }
  ]

  ingress_security_rules = [
    {
      protocol = "6"
      source   = "0.0.0.0/0"

      tcp_options {
        "min" = 8200
        "max" = 8200
      }
    },
  ]

  lifecycle {
    ignore_changes = ["egress_security_rules","ingress_security_rules"]
  }
}

resource "oci_core_security_list" "NatSecurityList" {
  count          = "${var.control_plane_subnet_access == "private" ? "1" : "0"}"
  compartment_id = "${(var.multiple_compartments == "true")  ? var.nat_compartment_ocid : var.compartment_ocid}"
  display_name   = "NATSeclist"
  vcn_id         = "${oci_core_virtual_network.CompleteVCN.id}"

  egress_security_rules = [{
    protocol    = "all"
    destination = "0.0.0.0/0"
  }]

  ingress_security_rules = [
    {
      protocol = "all"
      source   = "${lookup(var.bmc_ingress_cidrs, "VCN-CIDR")}"
    }
  ]

  lifecycle {
    ignore_changes = ["egress_security_rules","ingress_security_rules"]
  }
}

resource "oci_core_security_list" "BastionSecurityList" {
  count          = "${(var.control_plane_subnet_access == "private") && (var.dedicated_bastion_subnets == "true") ? "1" : "
0"}"
  compartment_id = "${(var.multiple_compartments == "true")  ? var.bastion_compartment_ocid : var.compartment_ocid}"
  display_name   = "${var.label_prefix}BastionSeclist"
  vcn_id         = "${oci_core_virtual_network.CompleteVCN.id}"

  egress_security_rules = [    
    {
      protocol = "6"
      destination = "${lookup(var.bmc_ingress_cidrs, "VCN-CIDR")}"

      tcp_options {
        "min" = 22
        "max" = 22
      }
    },

  ]

  ingress_security_rules = [
    {
      protocol = "6"
      source   = "156.151.0.0/16"

      tcp_options {
        "min" = 22
        "max" = 22
      }
    },
    {
      protocol = "6"
      source   = "137.254.7.160/27"

      tcp_options {
        "min" = 22
        "max" = 22
      }
    },
    {
      protocol = "6"
      source   = "148.87.23.0/27"

      tcp_options {
        "min" = 22
        "max" = 22
      }
    },
    {
      protocol = "6"
      source   = "148.87.66.160/27"

      tcp_options {
        "min" = 22
        "max" = 22
      }
    },
    {
      protocol = "6"
      source   = "209.17.37.96/27"

      tcp_options {
        "min" = 22
        "max" = 22
      }
    },
    {
      protocol = "6"
      source   = "209.17.40.32/27"

      tcp_options {
        "min" = 22
        "max" = 22
      }
    },
    {
      protocol = "6"
      source   = "148.87.0.0/16"

      tcp_options {
        "min" = 22
        "max" = 22
      }
    },
    {
      protocol = "6"
      source   = "130.61.0.0/16"

      tcp_options {
        "min" = 22
        "max" = 22
      }
    },
  ]

  lifecycle {
    ignore_changes = ["egress_security_rules","ingress_security_rules"]
  }
}

resource "oci_core_security_list" "GlobalSecurityList" {
  compartment_id = "${(var.multiple_compartments == "true")  ? var.network_compartment_ocid : var.compartment_ocid}"
  display_name   = "${var.label_prefix}GlobalSeclist"
  vcn_id         = "${oci_core_virtual_network.CompleteVCN.id}"

  egress_security_rules = [
    {
      destination = "0.0.0.0/0"
      protocol    = "all"
    },
  ]

  ingress_security_rules = [
    {
      tcp_options {
        "max" = 22
        "min" = 22
      }

      protocol = "6"
      source   = "10.0.60.0/24"
    },
    {
      tcp_options {
        "max" = 22
        "min" = 22
      }

      protocol = "6"
      source   = "10.0.61.0/24"
    },
    {
      tcp_options {
        "max" = 22
        "min" = 22
      }

      protocol = "6"
      source   = "10.0.62.0/24"
    }
  ]

  lifecycle {
    ignore_changes = ["egress_security_rules","ingress_security_rules"]
  }

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_security_list" "ManagementSecurityList" {
  compartment_id = "${(var.multiple_compartments == "true")  ? var.bastion_compartment_ocid : var.compartment_ocid}"
  display_name   = "${var.label_prefix}ManagementSeclist"
  vcn_id         = "${oci_core_virtual_network.CompleteVCN.id}"

  egress_security_rules = [
    {
      destination = "0.0.0.0/0"
      protocol    = "all"
    },
    {
      protocol = "6"
      destination = "10.0.30.0/24"

      tcp_options {
        "min" = 443
        "max" = 443
      }
    },
    {
      protocol = "6"
      destination = "10.0.31.0/24"

      tcp_options {
        "min" = 443
        "max" = 443
      }
    },
    {
      protocol = "6"
      destination = "10.0.32.0/24"

      tcp_options {
        "min" = 443
        "max" = 443
      }
    },
    {
      protocol = "6"
      destination = "10.0.40.0/24"

      tcp_options {
        "min" = 32000
        "max" = 32003
      }
    },
    {
      protocol = "6"
      destination = "10.0.41.0/24"

      tcp_options {
        "min" = 32000
        "max" = 32003
      }
    },
    {
      protocol = "6"
      destination = "10.0.42.0/24"

      tcp_options {
        "min" = 32000
        "max" = 32003
      }
    },
  ]

  ingress_security_rules = [
    {
      tcp_options {
        "max" = 22
        "min" = 22
      }

      protocol = "6"
      source   = "10.0.16.0/24"
    },
    {
      tcp_options {
        "max" = 22
        "min" = 22
      }

      protocol = "6"
      source   = "10.0.17.0/24"
    },
    {
      tcp_options {
        "max" = 22
        "min" = 22
      }

      protocol = "6"
      source   = "10.0.18.0/24"
    }
  ]

  lifecycle {
    ignore_changes = ["egress_security_rules","ingress_security_rules"]
  }

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_security_list" "ServiceProxySecurityList" {
  compartment_id = "${(var.multiple_compartments == "true")  ? var.bastion_compartment_ocid : var.compartment_ocid}"
  display_name   = "${var.label_prefix}ServiceProxySeclist"
  vcn_id         = "${oci_core_virtual_network.CompleteVCN.id}"

  egress_security_rules = [
    {
      destination = "0.0.0.0/0"
      protocol    = "all"
    },
  ]

  ingress_security_rules = [
    {
      protocol = "all"
      source   = "0.0.0.0/0"
    },
  ]

  lifecycle {
    ignore_changes = ["egress_security_rules","ingress_security_rules"]
  }

  provisioner "local-exec" {
    command = "sleep 5"
  }
}
