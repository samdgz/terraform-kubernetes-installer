### CA and Cluster Certificates

module "k8s-tls" {
  source                 = "./tls/"
  api_server_private_key = "${var.api_server_private_key}"
  api_server_cert        = "${var.api_server_cert}"
  ca_cert                = "${var.ca_cert}"
  ca_key                 = "${var.ca_key}"
  api_server_admin_token = "${var.api_server_admin_token}"
  master_lb_public_ip    = "${module.k8smaster-public-lb.ip_addresses[0]}"
  ssh_private_key        = "${var.ssh_private_key}"
  ssh_public_key_openssh = "${var.ssh_public_key_openssh}"
}

### Virtual Cloud Network

module "vcn" {
  source                                  = "./network/vcn"
  compartment_ocid                        = "${var.compartment_ocid}"
  label_prefix                            = "${var.label_prefix}"
  tenancy_ocid                            = "${var.tenancy_ocid}"
  vcn_dns_name                            = "${var.vcn_dns_name}"
  additional_etcd_security_lists_ids      = "${var.additional_etcd_security_lists_ids}"
  additional_k8smaster_security_lists_ids = "${var.additional_k8s_master_security_lists_ids}"
  additional_k8sworker_security_lists_ids = "${var.additional_k8s_worker_security_lists_ids}"
  additional_public_security_lists_ids    = "${var.additional_public_security_lists_ids}"
  control_plane_subnet_access             = "${var.control_plane_subnet_access}"
  etcd_ssh_ingress                        = "${var.etcd_ssh_ingress}"
  etcd_cluster_ingress                    = "${var.etcd_cluster_ingress}"
  master_ssh_ingress                      = "${var.master_ssh_ingress}"
  master_https_ingress                    = "${var.master_https_ingress}"
  public_subnet_ssh_ingress               = "${var.public_subnet_ssh_ingress}"
  public_subnet_http_ingress              = "${var.public_subnet_http_ingress}"
  public_subnet_https_ingress             = "${var.public_subnet_https_ingress}"
  nat_instance_oracle_linux_image_name    = "${var.nat_ol_image_name}"
  nat_instance_shape                      = "${var.natInstanceShape}"
  nat_instance_ad1_enabled                = "${var.nat_instance_ad1_enabled}"
  nat_instance_ad2_enabled                = "${var.nat_instance_ad2_enabled}"
  nat_instance_ad3_enabled                = "${var.nat_instance_ad3_enabled}"
  nat_instance_ssh_public_key_openssh     = "${module.k8s-tls.ssh_public_key_openssh}"
  worker_ssh_ingress                      = "${var.worker_ssh_ingress}"
  worker_nodeport_ingress                 = "${var.worker_nodeport_ingress}"
}

### Compute Instance(s)

module "instances-etcd-ad1" {
  source                    = "./instances/etcd"
  count                     = "${var.etcdAd1Count}"
  availability_domain       = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  compartment_ocid          = "${var.compartment_ocid}"
  display_name              = "etcd-ad1"
  domain_name               = "${var.domain_name}"
  etcd_discovery_url        = "${template_file.etcd_discovery_url.id}"
  flannel_backend           = "${var.flannel_backend}"
  flannel_network_cidr      = "10.99.0.0/16"
  flannel_network_subnetlen = 24
  hostname_label            = "etcd-ad1"
  oracle_linux_image_name   = "${var.etcd_ol_image_name}"
  label_prefix              = "${var.label_prefix}"
  image                     = "${var.oci_core_image}"
  shape                     = "${var.etcdShape}"
  ssh_public_key_openssh    = "${module.k8s-tls.ssh_public_key_openssh}"
  subnet_id                 = "${module.vcn.etcd_subnet_ad1_id}"
  tenancy_ocid              = "${var.compartment_ocid}"
  etcd_docker_max_log_size  = "${var.etcd_docker_max_log_size}"
  etcd_docker_max_log_files = "${var.etcd_docker_max_log_files}"
  etcd_iscsi_volume_create  = "${var.etcd_iscsi_volume_create}"
  etcd_iscsi_volume_size    = "${var.etcd_iscsi_volume_size}"
}

module "instances-etcd-ad2" {
  source                    = "./instances/etcd"
  count                     = "${var.etcdAd2Count}"
  availability_domain       = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  compartment_ocid          = "${var.compartment_ocid}"
  display_name              = "etcd-ad2"
  domain_name               = "${var.domain_name}"
  etcd_discovery_url        = "${template_file.etcd_discovery_url.id}"
  flannel_backend           = "${var.flannel_backend}"
  flannel_network_cidr      = "10.99.0.0/16"
  flannel_network_subnetlen = 24
  hostname_label            = "etcd-ad2"
  oracle_linux_image_name   = "${var.etcd_ol_image_name}"
  label_prefix              = "${var.label_prefix}"
  image                     = "${var.oci_core_image}"
  shape                     = "${var.etcdShape}"
  ssh_public_key_openssh    = "${module.k8s-tls.ssh_public_key_openssh}"
  subnet_id                 = "${module.vcn.etcd_subnet_ad2_id}"
  tenancy_ocid              = "${var.compartment_ocid}"
  etcd_docker_max_log_size  = "${var.etcd_docker_max_log_size}"
  etcd_docker_max_log_files = "${var.etcd_docker_max_log_files}"
  etcd_iscsi_volume_create  = "${var.etcd_iscsi_volume_create}"
  etcd_iscsi_volume_size    = "${var.etcd_iscsi_volume_size}"

}

module "instances-etcd-ad3" {
  source                    = "./instances/etcd"
  count                     = "${var.etcdAd3Count}"
  availability_domain       = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  compartment_ocid          = "${var.compartment_ocid}"
  display_name              = "etcd-ad3"
  docker_ver                = "${var.docker_ver}"
  domain_name               = "${var.domain_name}"
  etcd_discovery_url        = "${template_file.etcd_discovery_url.id}"
  etcd_ver                  = "${var.etcd_ver}"
  flannel_backend           = "${var.flannel_backend}"
  flannel_network_cidr      = "10.99.0.0/16"
  flannel_network_subnetlen = 24
  hostname_label            = "etcd-ad3"
  oracle_linux_image_name   = "${var.etcd_ol_image_name}"
  label_prefix              = "${var.label_prefix}"
  image                     = "${var.oci_core_image}"
  shape                     = "${var.etcdShape}"
  ssh_public_key_openssh    = "${module.k8s-tls.ssh_public_key_openssh}"
  subnet_id                 = "${module.vcn.etcd_subnet_ad3_id}"
  tenancy_ocid              = "${var.compartment_ocid}"
  etcd_docker_max_log_size  = "${var.etcd_docker_max_log_size}"
  etcd_docker_max_log_files = "${var.etcd_docker_max_log_files}"
  etcd_iscsi_volume_create  = "${var.etcd_iscsi_volume_create}"
  etcd_iscsi_volume_size    = "${var.etcd_iscsi_volume_size}"
}

module "instances-k8smaster-ad1" {
  source                     = "./instances/k8smaster"
  count                      = "${var.k8sMasterAd1Count}"
  api_server_cert_pem        = "${module.k8s-tls.api_server_cert_pem}"
  api_server_count           = "${var.k8sMasterAd1Count + var.k8sMasterAd2Count + var.k8sMasterAd3Count}"
  api_server_private_key_pem = "${module.k8s-tls.api_server_private_key_pem}"
  availability_domain        = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  k8s_apiserver_token_admin  = "${module.k8s-tls.api_server_admin_token}"
  compartment_ocid           = "${var.compartment_ocid}"
  display_name_prefix        = "k8s-master-ad1"
  docker_ver                 = "${var.docker_ver}"
  master_docker_max_log_size = "${var.master_docker_max_log_size}"
  master_docker_max_log_files = "${var.master_docker_max_log_files}"
  domain_name                = "${var.domain_name}"
  etcd_discovery_url         = "${template_file.etcd_discovery_url.id}"
  etcd_ver                   = "${var.etcd_ver}"
  flannel_ver                = "${var.flannel_ver}"
  hostname_label_prefix      = "k8s-master-ad1"
  oracle_linux_image_name    = "${var.master_ol_image_name}"
  k8s_dashboard_ver          = "${var.k8s_dashboard_ver}"
  k8s_dns_ver                = "${var.k8s_dns_ver}"
  k8s_ver                    = "${var.k8s_ver}"
  label_prefix               = "${var.label_prefix}"
  root_ca_pem                = "${module.k8s-tls.root_ca_pem}"
  image                      = "${var.oci_core_image}"
  shape                      = "${var.k8sMasterShape}"
  ssh_public_key_openssh     = "${module.k8s-tls.ssh_public_key_openssh}"
  subnet_id                  = "${module.vcn.k8smaster_subnet_ad1_id}"
  tenancy_ocid               = "${var.compartment_ocid}"
  etcd_endpoints             = "${var.etcd_lb_enabled=="true" ?
                                    join(",",formatlist("http://%s:2379",
                                                              module.etcd-lb.ip_addresses)):
                                    join(",",formatlist("http://%s:2379",compact(concat(
                                                              module.instances-etcd-ad1.private_ips,
                                                              module.instances-etcd-ad2.private_ips,
                                                              module.instances-etcd-ad3.private_ips)))) }"
}

module "instances-k8smaster-ad2" {
  source                     = "./instances/k8smaster"
  count                      = "${var.k8sMasterAd2Count}"
  api_server_cert_pem        = "${module.k8s-tls.api_server_cert_pem}"
  api_server_count           = "${var.k8sMasterAd1Count + var.k8sMasterAd2Count + var.k8sMasterAd3Count}"
  api_server_private_key_pem = "${module.k8s-tls.api_server_private_key_pem}"
  availability_domain        = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  k8s_apiserver_token_admin  = "${module.k8s-tls.api_server_admin_token}"
  compartment_ocid           = "${var.compartment_ocid}"
  display_name_prefix        = "k8s-master-ad2"
  docker_ver                 = "${var.docker_ver}"
  master_docker_max_log_size = "${var.master_docker_max_log_size}"
  master_docker_max_log_files = "${var.master_docker_max_log_files}"
  domain_name                = "${var.domain_name}"
  etcd_discovery_url         = "${template_file.etcd_discovery_url.id}"
  etcd_ver                   = "${var.etcd_ver}"
  flannel_ver                = "${var.flannel_ver}"
  hostname_label_prefix      = "k8s-master-ad2"
  oracle_linux_image_name    = "${var.master_ol_image_name}"
  k8s_dashboard_ver          = "${var.k8s_dashboard_ver}"
  k8s_dns_ver                = "${var.k8s_dns_ver}"
  k8s_ver                    = "${var.k8s_ver}"
  label_prefix               = "${var.label_prefix}"
  root_ca_pem                = "${module.k8s-tls.root_ca_pem}"
  image                      = "${var.oci_core_image}"
  shape                      = "${var.k8sMasterShape}"
  ssh_public_key_openssh     = "${module.k8s-tls.ssh_public_key_openssh}"
  subnet_id                  = "${module.vcn.k8smaster_subnet_ad2_id}"
  tenancy_ocid               = "${var.compartment_ocid}"
  etcd_endpoints             = "${var.etcd_lb_enabled=="true" ?
                                    join(",",formatlist("http://%s:2379",
                                                              module.etcd-lb.ip_addresses)) :
                                    join(",",formatlist("http://%s:2379",compact(concat(
                                                              module.instances-etcd-ad1.private_ips,
                                                              module.instances-etcd-ad2.private_ips,
                                                              module.instances-etcd-ad3.private_ips)))) }"
}

module "instances-k8smaster-ad3" {
  source                     = "./instances/k8smaster"
  count                      = "${var.k8sMasterAd3Count}"
  api_server_cert_pem        = "${module.k8s-tls.api_server_cert_pem}"
  api_server_count           = "${var.k8sMasterAd1Count + var.k8sMasterAd2Count + var.k8sMasterAd3Count}"
  api_server_private_key_pem = "${module.k8s-tls.api_server_private_key_pem}"
  availability_domain        = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  k8s_apiserver_token_admin  = "${module.k8s-tls.api_server_admin_token}"
  compartment_ocid           = "${var.compartment_ocid}"
  display_name_prefix        = "k8s-master-ad3"
  docker_ver                 = "${var.docker_ver}"
  master_docker_max_log_size = "${var.master_docker_max_log_size}"
  master_docker_max_log_files = "${var.master_docker_max_log_files}"
  domain_name                = "${var.domain_name}"
  etcd_discovery_url         = "${template_file.etcd_discovery_url.id}"
  etcd_ver                   = "${var.etcd_ver}"
  flannel_ver                = "${var.flannel_ver}"
  hostname_label_prefix      = "k8s-master-ad3"
  oracle_linux_image_name    = "${var.master_ol_image_name}"
  k8s_dashboard_ver          = "${var.k8s_dashboard_ver}"
  k8s_dns_ver                = "${var.k8s_dns_ver}"
  k8s_ver                    = "${var.k8s_ver}"
  label_prefix               = "${var.label_prefix}"
  root_ca_pem                = "${module.k8s-tls.root_ca_pem}"
  image                      = "${var.oci_core_image}"
  shape                      = "${var.k8sMasterShape}"
  ssh_public_key_openssh     = "${module.k8s-tls.ssh_public_key_openssh}"
  subnet_id                  = "${module.vcn.k8smaster_subnet_ad3_id}"
  tenancy_ocid               = "${var.compartment_ocid}"
  etcd_endpoints             = "${var.etcd_lb_enabled=="true" ?
                                    join(",",formatlist("http://%s:2379",
                                                              module.etcd-lb.ip_addresses)):
                                    join(",",formatlist("http://%s:2379",compact(concat(
                                                              module.instances-etcd-ad1.private_ips,
                                                              module.instances-etcd-ad2.private_ips,
                                                              module.instances-etcd-ad3.private_ips)))) }"
}

module "instances-k8sworker-ad1" {
  source                     = "./instances/k8sworker"
  count                      = "${var.k8sWorkerAd1Count}"
  api_server_cert_pem        = "${module.k8s-tls.api_server_cert_pem}"
  api_server_private_key_pem = "${module.k8s-tls.api_server_private_key_pem}"
  availability_domain        = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  compartment_ocid           = "${var.compartment_ocid}"
  display_name_prefix        = "k8s-worker-ad1"
  docker_ver                 = "${var.docker_ver}"
  worker_docker_max_log_size = "${var.worker_docker_max_log_size}"
  worker_docker_max_log_files = "${var.worker_docker_max_log_files}"
  domain_name                = "${var.domain_name}"
  etcd_discovery_url         = "${template_file.etcd_discovery_url.id}"
  etcd_ver                   = "${var.etcd_ver}"
  flannel_ver                = "${var.flannel_ver}"
  hostname_label_prefix      = "k8s-worker-ad1"
  oracle_linux_image_name    = "${var.worker_ol_image_name}"
  k8s_ver                    = "${var.k8s_ver}"
  label_prefix               = "${var.label_prefix}"
  master_lb                  = "https://${module.k8smaster-public-lb.ip_addresses[0]}:443"
  region                     = "${var.region}"
  root_ca_key                = "${module.k8s-tls.root_ca_key}"
  root_ca_pem                = "${module.k8s-tls.root_ca_pem}"
  image                      = "${var.oci_core_image}"
  shape                      = "${var.k8sWorkerShape}"
  ssh_private_key            = "${module.k8s-tls.ssh_private_key}"
  ssh_public_key_openssh     = "${module.k8s-tls.ssh_public_key_openssh}"
  subnet_id                  = "${module.vcn.k8worker_subnet_ad1_id}"
  tenancy_ocid               = "${var.compartment_ocid}"
  etcd_endpoints             = "${var.etcd_lb_enabled=="true" ?
                                    join(",",formatlist("http://%s:2379",
                                                              module.etcd-lb.ip_addresses)):
                                    join(",",formatlist("http://%s:2379",compact(concat(
                                                              module.instances-etcd-ad1.private_ips,
                                                              module.instances-etcd-ad2.private_ips,
                                                              module.instances-etcd-ad3.private_ips)))) }"
  worker_iscsi_volume_create = "${var.worker_iscsi_volume_create}"
  worker_iscsi_volume_size   = "${var.worker_iscsi_volume_size}"
  worker_iscsi_volume_mount  = "${var.worker_iscsi_volume_mount}"
}

module "instances-k8sworker-ad2" {
  source                     = "./instances/k8sworker"
  count                      = "${var.k8sWorkerAd2Count}"
  api_server_cert_pem        = "${module.k8s-tls.api_server_cert_pem}"
  api_server_private_key_pem = "${module.k8s-tls.api_server_private_key_pem}"
  availability_domain        = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  compartment_ocid           = "${var.compartment_ocid}"
  display_name_prefix        = "k8s-worker-ad2"
  docker_ver                 = "${var.docker_ver}"
  worker_docker_max_log_size = "${var.worker_docker_max_log_size}"
  worker_docker_max_log_files = "${var.worker_docker_max_log_files}"
  domain_name                = "${var.domain_name}"
  etcd_discovery_url         = "${template_file.etcd_discovery_url.id}"
  etcd_ver                   = "${var.etcd_ver}"
  flannel_ver                = "${var.flannel_ver}"
  hostname_label_prefix      = "k8s-worker-ad2"
  oracle_linux_image_name    = "${var.worker_ol_image_name}"
  k8s_ver                    = "${var.k8s_ver}"
  label_prefix               = "${var.label_prefix}"
  master_lb                  = "https://${module.k8smaster-public-lb.ip_addresses[0]}:443"
  region                     = "${var.region}"
  root_ca_key                = "${module.k8s-tls.root_ca_key}"
  root_ca_pem                = "${module.k8s-tls.root_ca_pem}"
  image                      = "${var.oci_core_image}"
  shape                      = "${var.k8sWorkerShape}"
  ssh_private_key            = "${module.k8s-tls.ssh_private_key}"
  ssh_public_key_openssh     = "${module.k8s-tls.ssh_public_key_openssh}"
  subnet_id                  = "${module.vcn.k8worker_subnet_ad2_id}"
  tenancy_ocid               = "${var.compartment_ocid}"
  etcd_endpoints             = "${var.etcd_lb_enabled=="true" ?
                                    join(",",formatlist("http://%s:2379",
                                                              module.etcd-lb.ip_addresses)):
                                    join(",",formatlist("http://%s:2379",compact(concat(
                                                              module.instances-etcd-ad1.private_ips,
                                                              module.instances-etcd-ad2.private_ips,
                                                              module.instances-etcd-ad3.private_ips)))) }"
  worker_iscsi_volume_create = "${var.worker_iscsi_volume_create}"
  worker_iscsi_volume_size   = "${var.worker_iscsi_volume_size}"
  worker_iscsi_volume_mount  = "${var.worker_iscsi_volume_mount}"
}

module "instances-k8sworker-ad3" {
  source                     = "./instances/k8sworker"
  count                      = "${var.k8sWorkerAd3Count}"
  api_server_cert_pem        = "${module.k8s-tls.api_server_cert_pem}"
  api_server_private_key_pem = "${module.k8s-tls.api_server_private_key_pem}"
  availability_domain        = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  compartment_ocid           = "${var.compartment_ocid}"
  display_name_prefix        = "k8s-worker-ad3"
  docker_ver                 = "${var.docker_ver}"
  worker_docker_max_log_size = "${var.worker_docker_max_log_size}"
  worker_docker_max_log_files = "${var.worker_docker_max_log_files}"
  domain_name                = "${var.domain_name}"
  etcd_discovery_url         = "${template_file.etcd_discovery_url.id}"
  etcd_ver                   = "${var.etcd_ver}"
  flannel_ver                = "${var.flannel_ver}"
  hostname_label_prefix      = "k8s-worker-ad3"
  oracle_linux_image_name    = "${var.worker_ol_image_name}"
  k8s_ver                    = "${var.k8s_ver}"
  label_prefix               = "${var.label_prefix}"
  master_lb                  = "https://${module.k8smaster-public-lb.ip_addresses[0]}:443"
  region                     = "${var.region}"
  root_ca_key                = "${module.k8s-tls.root_ca_key}"
  root_ca_pem                = "${module.k8s-tls.root_ca_pem}"
  image                      = "${var.oci_core_image}"
  shape                      = "${var.k8sWorkerShape}"
  ssh_private_key            = "${module.k8s-tls.ssh_private_key}"
  ssh_public_key_openssh     = "${module.k8s-tls.ssh_public_key_openssh}"
  subnet_id                  = "${module.vcn.k8worker_subnet_ad3_id}"
  tenancy_ocid               = "${var.compartment_ocid}"
  etcd_endpoints             = "${var.etcd_lb_enabled=="true" ?
                                    join(",",formatlist("http://%s:2379",
                                                              module.etcd-lb.ip_addresses)):
                                    join(",",formatlist("http://%s:2379",compact(concat(
                                                              module.instances-etcd-ad1.private_ips,
                                                              module.instances-etcd-ad2.private_ips,
                                                              module.instances-etcd-ad3.private_ips)))) }"
  worker_iscsi_volume_create = "${var.worker_iscsi_volume_create}"
  worker_iscsi_volume_size   = "${var.worker_iscsi_volume_size}"
  worker_iscsi_volume_mount  = "${var.worker_iscsi_volume_mount}"
}

### Load Balancers

module "etcd-lb" {
  source               = "./network/loadbalancers/etcd"
  count                = "${var.etcd_lb_enabled=="true"? 1 : 0 }"
  etcd_lb_enabled        = "${var.etcd_lb_enabled}"
  compartment_ocid     = "${var.compartment_ocid}"
  is_private       = "${var.etcd_lb_access == "private" ? "true": "false"}"
  # Handle case where var.etcd_lb_access=public, but var.control_plane_subnet_access=private
  etcd_subnet_0_id     = "${var.etcd_lb_access == "private" ? module.vcn.etcd_subnet_ad1_id: coalesce(join(" ", module.vcn.public_subnet_ad1_id), join(" ", list(module.vcn.etcd_subnet_ad1_id)))}"
  etcd_subnet_1_id     = "${var.etcd_lb_access == "private" ? "": coalesce(join(" ", module.vcn.public_subnet_ad2_id), join(" ", list(module.vcn.etcd_subnet_ad2_id)))}"
  etcd_ad1_private_ips = "${module.instances-etcd-ad1.private_ips}"
  etcd_ad2_private_ips = "${module.instances-etcd-ad2.private_ips}"
  etcd_ad3_private_ips = "${module.instances-etcd-ad3.private_ips}"
  etcdAd1Count         = "${var.etcdAd1Count}"
  etcdAd2Count         = "${var.etcdAd2Count}"
  etcdAd3Count         = "${var.etcdAd3Count}"
  label_prefix         = "${var.label_prefix}"
  shape                = "${var.etcdLBShape}"
}

module "k8smaster-public-lb" {
  source           = "./network/loadbalancers/k8smaster"
  compartment_ocid = "${var.compartment_ocid}"
  is_private       = "${var.k8s_master_lb_access == "private" ? "true": "false"}"

  # Handle case where var.k8s_master_lb_access=public, but var.control_plane_subnet_access=private
  k8smaster_subnet_0_id     = "${var.k8s_master_lb_access == "private" ? module.vcn.k8smaster_subnet_ad1_id: coalesce(join(" ", module.vcn.public_subnet_ad1_id), join(" ", list(module.vcn.k8smaster_subnet_ad1_id)))}"
  k8smaster_subnet_1_id     = "${var.k8s_master_lb_access == "private" ? "": coalesce(join(" ", module.vcn.public_subnet_ad2_id), join(" ", list(module.vcn.k8smaster_subnet_ad2_id)))}"
  k8smaster_ad1_private_ips = "${module.instances-k8smaster-ad1.private_ips}"
  k8smaster_ad2_private_ips = "${module.instances-k8smaster-ad2.private_ips}"
  k8smaster_ad3_private_ips = "${module.instances-k8smaster-ad3.private_ips}"
  k8sMasterAd1Count         = "${var.k8sMasterAd1Count}"
  k8sMasterAd2Count         = "${var.k8sMasterAd2Count}"
  k8sMasterAd3Count         = "${var.k8sMasterAd3Count}"
  label_prefix              = "${var.label_prefix}"
  shape                     = "${var.k8sMasterLBShape}"
}

module "kubeconfig" {
  source                     = "./kubernetes/kubeconfig"
  api_server_private_key_pem = "${module.k8s-tls.api_server_private_key_pem}"
  api_server_cert_pem        = "${module.k8s-tls.api_server_cert_pem}"
  k8s_master                 = "https://${module.k8smaster-public-lb.ip_addresses[0]}:443"
}
