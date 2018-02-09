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

data "template_file" "nginx" {
  template = "${file("${path.module}/nginx/nginx.conf")}"

  vars {
    servers = "${join("\n", formatlist("        server %s.example.com;", var.hosts))}"
  }
}

output "ccd2" {
  value = "${join("\n", formatlist("        server %s.example.com;", var.hosts))}"
}
output "ccd3" {
  value = "${data.template_file.nginx.rendered}"
}
resource "null_resource" "ansible-provision" { 
    provisioner "local-exec" {
    command = "echo '${join("\n", formatlist("%s.example.com", var.hosts))}' > ansible_hosts"
    }
}