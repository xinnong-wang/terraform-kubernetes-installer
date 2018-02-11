# Outputs

output "ip_addresses" {
  value = "${flatten(oci_load_balancer.lb-k8smaster.*.ip_addresses)}"
}

output "load_balancer_id" {
  value = "${oci_load_balancer.lb-k8smaster.*.id}"
}

output "backendset_name" {
  value = "${oci_load_balancer_backendset.lb-k8smaster-https.*.name}"
}

# output "k8s_master_ip" {
#   value = "${format("https://%s:443", element(concat(oci_load_balancer.lb-k8smaster.*.ip_addresses, 
#   list("127.0.0.1")), 0), var.master_lb_enabled?"443":"6443")}"
# }
