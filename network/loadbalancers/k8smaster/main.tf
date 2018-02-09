resource "oci_load_balancer" "lb-k8smaster" {
  count          = "${var.count}"
  shape          = "${var.shape}"
  compartment_id = "${var.compartment_ocid}"

  subnet_ids = ["${compact(list(var.k8smaster_subnet_0_id,var.k8smaster_subnet_1_id))}"]

  display_name = "${var.label_prefix}lb-k8smaster"
  is_private   = "${var.is_private}"
}

resource "oci_load_balancer_backendset" "lb-k8smaster-https" {
  count          = "${var.count}"
  name             = "backendset-https"
  load_balancer_id = "${oci_load_balancer.lb-k8smaster.id}"
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = 443
    protocol            = "TCP"
    response_body_regex = ".*"
  }
}

resource "oci_load_balancer_listener" "port-https" {
  count          = "${var.count}"
  load_balancer_id         = "${oci_load_balancer.lb-k8smaster.id}"
  name                     = "port-https"
  default_backend_set_name = "${oci_load_balancer_backendset.lb-k8smaster-https.id}"
  port                     = 443
  protocol                 = "TCP"
}

resource "oci_load_balancer_backend" "k8smaster-backends-ad1" {
  count            = "${var.master_lb_enabled=="false" ? 0 : var.k8sMasterAd1Count}"
  load_balancer_id = "${var.master_lb_enabled=="false"? "": oci_load_balancer.lb-k8smaster.*.id[0]}"
  backendset_name  = "${var.master_lb_enabled=="false"? "": oci_load_balancer_backendset.lb-k8smaster-https.*.name[0]}"
  ip_address       = "${element(var.k8smaster_ad1_private_ips, count.index)}"
  port             = "443"
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "k8smaster-backends-ad2" {
  load_balancer_id = "${oci_load_balancer.lb-k8smaster.id}"
  backendset_name  = "${oci_load_balancer_backendset.lb-k8smaster-https.name}"
  count            = "${var.master_lb_enabled=="false" ? 0 : var.k8sMasterAd2Count}"
  ip_address       = "${element(var.k8smaster_ad2_private_ips, count.index)}"
  port             = "443"
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "k8smaster-backends-ad3" {
  load_balancer_id = "${oci_load_balancer.lb-k8smaster.id}"
  backendset_name  = "${oci_load_balancer_backendset.lb-k8smaster-https.name}"
  count            = "${var.master_lb_enabled=="false" ? 0 : var.k8sMasterAd3Count}"
  ip_address       = "${element(var.k8smaster_ad3_private_ips, count.index)}"
  port             = "443"
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}
