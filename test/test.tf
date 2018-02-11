variable "aa" {
  type    = "list"
  default = ["df", ""]
}

variable "hosts" {
  default = ["a", "b"]
}
variable "master_lb_enabled2" {
    default = "true"
}

output "bb" {
  value = "${format("https://%s:443", element(concat(var.aa, list("https://127.0.0.1:443")), 0))}"
}

output "cc" {
  value = ["${var.aa}", "dd"]
}

output "ccd" {
  value = "${var.aa}"
}

output "ccd2" {
  value = "${join("\n", formatlist("        server %s.example.com;", var.hosts))}"
}

output "etcdAd1Count333" {
  value = "${var.etcdAd1Count}"
}

output "dd2" {
  value = "${var.etcdAd1Count>0?1:0}"
}

