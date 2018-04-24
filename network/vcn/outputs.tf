output "id" {
  value = "${oci_core_virtual_network.CompleteVCN.id}"
}

output "etcd_subnet_ad1_id" {
  value = "${oci_core_subnet.etcdSubnetAD1.id}"
}

output "etcd_subnet_ad2_id" {
  value = "${oci_core_subnet.etcdSubnetAD2.id}"
}

output "etcd_subnet_ad3_id" {
  value = "${oci_core_subnet.etcdSubnetAD3.id}"
}

output "k8smaster_subnet_ad1_id" {
  value = "${oci_core_subnet.k8sMasterSubnetAD1.id}"
}

output "k8smaster_subnet_ad2_id" {
  value = "${oci_core_subnet.k8sMasterSubnetAD2.id}"
}

output "k8smaster_subnet_ad3_id" {
  value = "${oci_core_subnet.k8sMasterSubnetAD3.id}"
}

output "k8worker_subnet_ad1_id" {
  value = "${oci_core_subnet.k8sWorkerSubnetAD1.id}"
}

output "k8worker_subnet_ad2_id" {
  value = "${oci_core_subnet.k8sWorkerSubnetAD2.id}"
}

output "k8worker_subnet_ad3_id" {
  value = "${oci_core_subnet.k8sWorkerSubnetAD3.id}"
}

output "public_subnet_ad1_id" {
  value = "${oci_core_subnet.PublicSubnetAD1.*.id}"
}

output "public_subnet_ad2_id" {
  value = "${oci_core_subnet.PublicSubnetAD2.*.id}"
}

output "public_subnet_ad3_id" {
  value = "${oci_core_subnet.PublicSubnetAD3.*.id}"
}

output "nat_subnet_ad1_id" {
  value = "${oci_core_subnet.NATSubnetAD1.*.id}"
}

output "nat_subnet_ad2_id" {
  value = "${oci_core_subnet.NATSubnetAD2.*.id}"
}

output "nat_subnet_ad3_id" {
  value = "${oci_core_subnet.NATSubnetAD3.*.id}"
}

output "nat_instance_ad1_ids" {
  value = ["${oci_core_instance.NATInstanceAD1.*.id}"]
}

output "nat_instance_ad1_private_ips" {
  value = ["${oci_core_instance.NATInstanceAD1.*.private_ip}"]
}

output "nat_instance_ad1_public_ips" {
  value = ["${oci_core_instance.NATInstanceAD1.*.public_ip}"]
}

output "nat_instance_ad2_ids" {
  value = ["${oci_core_instance.NATInstanceAD2.*.id}"]
}

output "nat_instance_ad2_private_ips" {
  value = ["${oci_core_instance.NATInstanceAD2.*.private_ip}"]
}

output "nat_instance_ad2_public_ips" {
  value = ["${oci_core_instance.NATInstanceAD2.*.public_ip}"]
}

output "nat_instance_ad3_ids" {
  value = ["${oci_core_instance.NATInstanceAD3.*.id}"]
}

output "nat_instance_ad3_private_ips" {
  value = ["${oci_core_instance.NATInstanceAD3.*.private_ip}"]
}

output "nat_instance_ad3_public_ips" {
  value = ["${oci_core_instance.NATInstanceAD3.*.public_ip}"]
}

output "bastion_subnet_ad1_id" {
  value = "${oci_core_subnet.BastionSubnetAD1.*.id}"
}

output "bastion_subnet_ad2_id" {
  value = "${oci_core_subnet.BastionSubnetAD2.*.id}"
}

output "bastion_subnet_ad3_id" {
  value = "${oci_core_subnet.BastionSubnetAD3.*.id}"
}

output "bastion_instance_ad1_ids" {
  value = ["${oci_core_instance.BastionInstanceAD1.*.id}"]
}

output "bastion_instance_ad1_private_ips" {
  value = ["${oci_core_instance.BastionInstanceAD1.*.private_ip}"]
}

output "bastion_instance_ad1_public_ips" {
  value = ["${oci_core_instance.BastionInstanceAD1.*.public_ip}"]
}

output "bastion_instance_ad2_ids" {
  value = ["${oci_core_instance.BastionInstanceAD2.*.id}"]
}

output "bastion_instance_ad2_private_ips" {
  value = ["${oci_core_instance.BastionInstanceAD2.*.private_ip}"]
}

output "bastion_instance_ad2_public_ips" {
  value = ["${oci_core_instance.BastionInstanceAD2.*.public_ip}"]
}

output "bastion_instance_ad3_ids" {
  value = ["${oci_core_instance.BastionInstanceAD3.*.id}"]
}

output "bastion_instance_ad3_private_ips" {
  value = ["${oci_core_instance.BastionInstanceAD3.*.private_ip}"]
}

output "bastion_instance_ad3_public_ips" {
  value = ["${oci_core_instance.BastionInstanceAD3.*.public_ip}"]
}

output "control_plane_subnet_access" {
  value = "${var.control_plane_subnet_access}"
}

output "route_for_complete_id" {
  value = "${oci_core_route_table.PublicRouteTable.id}"
}

output "dhcp_options_id" {
  value = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"
}
output "management_subnet_ad1_id" {
  value = "${oci_core_subnet.ManagementSubnetAD1.*.id}"
}

output "management_subnet_ad2_id" {
  value = "${oci_core_subnet.ManagementSubnetAD2.*.id}"
}

output "management_subnet_ad3_id" {
  value = "${oci_core_subnet.ManagementSubnetAD3.*.id}"
}

output "management_instance_ad1_ids" {
  value = ["${oci_core_instance.ManagementInstanceAD1.*.id}"]
}

output "management_instance_ad1_private_ips" {
  value = ["${oci_core_instance.ManagementInstanceAD1.*.private_ip}"]
}

output "management_instance_ad1_public_ips" {
  value = ["${oci_core_instance.ManagementInstanceAD1.*.public_ip}"]
}

output "management_instance_ad2_ids" {
  value = ["${oci_core_instance.ManagementInstanceAD2.*.id}"]
}

output "management_instance_ad2_private_ips" {
  value = ["${oci_core_instance.ManagementInstanceAD2.*.private_ip}"]
}

output "management_instance_ad2_public_ips" {
  value = ["${oci_core_instance.ManagementInstanceAD2.*.public_ip}"]
}

output "management_instance_ad3_ids" {
  value = ["${oci_core_instance.ManagementInstanceAD3.*.id}"]
}

output "management_instance_ad3_private_ips" {
  value = ["${oci_core_instance.ManagementInstanceAD3.*.private_ip}"]
}

output "management_instance_ad3_public_ips" {
  value = ["${oci_core_instance.ManagementInstanceAD3.*.public_ip}"]
}
output "serviceproxy_subnet_ad1_id" {
  value = "${oci_core_subnet.ServiceProxySubnetAD1.*.id}"
}

output "serviceproxy_subnet_ad2_id" {
  value = "${oci_core_subnet.ServiceProxySubnetAD2.*.id}"
}

output "serviceproxy_subnet_ad3_id" {
  value = "${oci_core_subnet.ServiceProxySubnetAD3.*.id}"
}

output "serviceproxy_instance_ad1_ids" {
  value = ["${oci_core_instance.ServiceProxyInstanceAD1.*.id}"]
}

output "serviceproxy_instance_ad1_private_ips" {
  value = ["${oci_core_instance.ServiceProxyInstanceAD1.*.private_ip}"]
}

output "serviceproxy_instance_ad1_public_ips" {
  value = ["${oci_core_instance.ServiceProxyInstanceAD1.*.public_ip}"]
}

output "serviceproxy_instance_ad2_ids" {
  value = ["${oci_core_instance.ServiceProxyInstanceAD2.*.id}"]
}

output "serviceproxy_instance_ad2_private_ips" {
  value = ["${oci_core_instance.ServiceProxyInstanceAD2.*.private_ip}"]
}

output "serviceproxy_instance_ad2_public_ips" {
  value = ["${oci_core_instance.ServiceProxyInstanceAD2.*.public_ip}"]
}

output "serviceproxy_instance_ad3_ids" {
  value = ["${oci_core_instance.ServiceProxyInstanceAD3.*.id}"]
}

output "serviceproxy_instance_ad3_private_ips" {
  value = ["${oci_core_instance.ServiceProxyInstanceAD3.*.private_ip}"]
}

output "serviceproxy_instance_ad3_public_ips" {
  value = ["${oci_core_instance.ServiceProxyInstanceAD3.*.public_ip}"]
}
